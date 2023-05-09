import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

const List<Map<String, dynamic>> iceServers = [
  {
    'url': 'stun:stun1.l.google.com:19302',
  },
  {
    'url': 'stun:stun2.l.google.com:19302',
  },
];

class WebRTCPage extends StatefulWidget {
  @override
  _WebRTCPageState createState() => _WebRTCPageState();
}

class _WebRTCPageState extends State<WebRTCPage> {
  late RTCPeerConnection _peerConnection;
  late MediaStream _localStream;
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    _signInAnonymously();
    _initializeRenderers();
    _createPeerConnection();
    _listenForCallChanges();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  Future<void> _signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  Future<void> _initializeRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  Future<void> _createPeerConnection() async {
    _localStream = await _getUserMedia();
    _peerConnection =
        await createPeerConnection({'iceServers': iceServers}, {});

    _peerConnection.addStream(_localStream);

    _peerConnection.onIceCandidate = (RTCIceCandidate candidate) async {
      if (candidate == null) {
        return;
      }
      final currentUser = FirebaseAuth.instance.currentUser;
      final callId = '123456';

      await FirebaseFirestore.instance
          .collection('calls')
          .doc(callId)
          .collection('iceCandidates')
          .add({
        'candidate': {
          'candidate': candidate.candidate,
          'sdpMid': candidate.sdpMid,
          'sdpMLineIndex': candidate.sdpMLineIndex,
        },
        'userId': currentUser?.uid,
      });
    };

    _peerConnection.onAddStream = (MediaStream stream) {
      _remoteRenderer.srcObject = stream;
    };
  }

  Future<MediaStream> _getUserMedia() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'mandatory': {
          'minWidth': '640',
          'minHeight': '480',
          'minFrameRate': '30',
        },
        'facingMode': 'user',
        'optional': [],
      }
    };

    return await navigator.mediaDevices.getUserMedia(mediaConstraints);
  }

  void _listenForCallChanges() {
    final currentUser = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('calls')
        .snapshots()
        .listen((querySnapshot) {
      querySnapshot.docChanges.forEach((docChange) async {
        final callData = docChange.doc.data();
        final callId = callData?['callId'];
        final callerId = callData?['callerId'];
        final offerData = callData?['offer'];
        final answerData = callData?['answer'];

        if (callerId != currentUser?.uid) {
          switch (docChange.type) {
            case DocumentChangeType.added:
              if (offerData != null) {
                final offer =
                    RTCSessionDescription(offerData['sdp'], offerData['type']);
                await _handleReceiveOffer(offer, callId);
              }
              break;
            case DocumentChangeType.modified:
              if (answerData != null) {
                final answer = RTCSessionDescription(
                    answerData['sdp'], answerData['type']);
                await _handleReceiveAnswer(answer);
              }
              break;
            case DocumentChangeType.removed:
              break;
            default:
              break;
          }
        }
      });
    });
  }

  Future<void> _handleSendOffer() async {
    final RTCSessionDescription offer = await _peerConnection.createOffer({});
    await _peerConnection.setLocalDescription(offer);

    final currentUser = FirebaseAuth.instance.currentUser;
    final callDocument = FirebaseFirestore.instance.collection('calls').doc();
    final offerData = <String, dynamic>{
      'sdp': offer.sdp,
      'type': offer.type,
      'callId': callDocument.id,
    };

    await callDocument.set(offerData);
  }

  Future<void> _handleSendAnswer(String callId) async {
    final RTCSessionDescription answer = await _peerConnection.createAnswer({});
    await _peerConnection.setLocalDescription(answer);

    final answerData = <String, dynamic>{
      'sdp': answer.sdp,
      'type': answer.type,
    };

    await FirebaseFirestore.instance.collection('calls').doc(callId).update({
      'answer': answerData,
    });
  }

  Future<void> _handleReceiveOffer(
      RTCSessionDescription offer, String callId) async {
    await _peerConnection.setRemoteDescription(offer);
    await _handleSendAnswer(callId);
  }

  Future<void> _handleReceiveAnswer(RTCSessionDescription answer) async {
    await _peerConnection.setRemoteDescription(answer);
  }

  Future<void> _endCall() async {
    _peerConnection.close();
    _localRenderer.srcObject = null;
    _remoteRenderer.srcObject = null;
    await _localStream.dispose();

    _createPeerConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WebRTC Video Chat')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Local video'),
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.black),
              child: SizedBox(
                width: 180,
                height: 135,
                child: RTCVideoView(_localRenderer),
              ),
            ),
            Text('Remote video'),
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.black),
              child: SizedBox(
                width: 180,
                height: 135,
                child: RTCVideoView(_remoteRenderer),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _handleSendOffer();
                  },
                  child: Text('Start Call'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _endCall();
                  },
                  child: Text('End Call'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
