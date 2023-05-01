import 'package:flutter/material.dart';
import 'package:stylish2023/Constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:stylish2023/Data/product_list.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class DetailPage extends StatefulWidget {
  final Product catalogItem;

  DetailPage({required this.catalogItem});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _quantity = 1;

  static const platform = MethodChannel('test_tappay');

  String _tappayMessage = 'Press the button to get a native string';

  Future<void> _inputCreditCard() async {
    String message;

    try {
      message = await platform.invokeMethod('getPrime');
    } on PlatformException catch (e) {
      message = "失敗 string: '${e.message}'.";
    }

    setState(() {
      _tappayMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: icBackgroundColor,
        title: Image.asset('images/STYLiSH_Logo.png',
            fit: BoxFit.cover, height: 20),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.catalogItem.mainImage,
              width: 360,
              height: 500,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.catalogItem.title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.catalogItem.id.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 18),
              child: Text(
                'NT\$ ${widget.catalogItem.price}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(children: [
                  Text('顏色', style: TextStyle(fontSize: 14)),
                  SizedBox(
                    width: 20,
                  ),
                  Container(width: 1, height: 16, color: Colors.grey),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                      width: 16,
                      height: 16,
                      decoration:
                          BoxDecoration(color: Colors.black, boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 1,
                            offset: Offset(0.5, 0.5))
                      ])),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    width: 16,
                    height: 16,
                    decoration:
                        BoxDecoration(color: Colors.deepPurple, boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 1,
                          offset: Offset(0.5, 0.5))
                    ]),
                  )
                ]),
                Row(children: [
                  Text('尺寸', style: TextStyle(fontSize: 14)),
                  SizedBox(
                    width: 20,
                  ),
                  Container(width: 1, height: 16, color: Colors.grey),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                      width: 30,
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('S',
                          style: TextStyle(color: Colors.white))),
                  Container(
                      width: 30,
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('M',
                          style: TextStyle(color: Colors.white))),
                  Container(
                      width: 30,
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('L',
                          style: TextStyle(color: Colors.white))),
                ]),
              ],
            ),
            Row(children: [
              Text('數量', style: TextStyle(fontSize: 14)),
              SizedBox(
                width: 20,
              ),
              Container(width: 1, height: 16, color: Colors.grey),
              SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Row(children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      _quantity = _quantity > 1 ? _quantity - 1 : 1;
                    });
                  },
                ),
                Text('$_quantity'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _quantity += 1;
                    });
                  },
                ),
              ]))
            ]),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
              child: SizedBox(
                width: 360,
                child: ElevatedButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.brown,
                  ),
                  onPressed: () {
                    /// Go to Tappay Page
                    _inputCreditCard;
                  },
                  child: const Text(
                    '請選擇尺寸',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            Text(_tappayMessage),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '實品顏色依單品照為主',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.catalogItem.texture,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.catalogItem.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '素材產地：${widget.catalogItem.place}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
