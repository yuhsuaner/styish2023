import UIKit
import TPDirect
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    private let channelName = "test_tappay"
    
    private let tpdID: Int32 = 12348
    private let tpdKey: String = "app_pa1pQcKoY22IlnSXq5m5WP5jFKzoRG58VEXpT7wU62ud7mMbDOGzCYIlzzLF"
    
    //    var tpdCard: TPDCard!
    //    var tpdForm: TPDForm!
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        TPDSetup.setWithAppId(tpdID,
                              withAppKey: tpdKey,
                              with: TPDServerType.sandBox)
        
//        TPDSetup.shareInstance().setupIDFA(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
//
//        TPDSetup.shareInstance().serverSync()
//
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)
        
        methodChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            
            guard let args = call.arguments as? [String: Any] else {
                result("args cast error")
                return
            }
            switch call.method {
            case "getPrime":
                self?.setupTappay(args: args) { tpdResult in
                    result(tpdResult)
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // private func goToTapPay(result: FlutterResult) {
    
    
    //     tpdCard = TPDCard.setup(tpdForm)
    
    // }
    
    private func setupTappay(args: [String: Any], completion: @escaping (String) -> Void) {
        
        let cardNumber = (args["cardNumber"] as? String ?? "")
        let dueMonth = (args["dueMonth"] as? String ?? "")
        let dueYear = (args["dueYear"] as? String ?? "")
        let ccv = (args["ccv"] as? String ?? "")
        
        let card = TPDCard.setWithCardNumber(cardNumber, withDueMonth: dueMonth, withDueYear: dueYear, withCCV: ccv)
        card.onSuccessCallback { (tpPrime, cardInfo, cardIdentifier, merchantReferenceInfo) in
            if let tpPrime = tpPrime {
                completion("{\"status\":\"\", \"message\":\"\", \"prime\":\"\(tpPrime)\"}")
            }
        }.onFailureCallback { (status, message) in
            completion("{\"status\":\"\(status)\", \"message\":\"\(message)\", \"prime\":\"\"}")
        }.createToken(withGeoLocation: "UNKNOWN")
    }
    
}
