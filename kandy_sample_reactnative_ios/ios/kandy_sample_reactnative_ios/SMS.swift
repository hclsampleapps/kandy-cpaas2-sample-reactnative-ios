
import  Foundation
import  CPaaSSDK
import UIKit
import Alamofire
import SwiftyJSON
import CPaaSSDK
import AVFoundation

@objc(SMS)

class SMS: RCTEventEmitter,CPSmsDelegate {

var cpaas: CPaaS!
  
//public static var shared:SMS?

override init() {
      super.init()
}
  
@objc func initSMSModule(_ callback:@escaping RCTResponseSenderBlock) {
     DispatchQueue.main.async {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.cpaas = appDelegate.cpassObj
        self.cpaas.smsService?.delegate = self
        callback([NSNull(),"sucess"])
    }
}
    
@objc func sendMessage(_ destinationNumber: String,sourceNumber: String,messageText: String,callback:@escaping RCTResponseSenderBlock) {  
  DispatchQueue.main.async {
  self.sendMessage(message: messageText, destinationNumber: destinationNumber, sourceNumber: sourceNumber) { (response) in
      if(response?.description == "error") {
             callback([NSNull()])
           }
           else {
             callback([NSNull(), "sucess"])
      }
  }
  }
}

func sendSms(destinationNumber: String,sourceNumber: String,messageText: String,callback: @escaping RCTResponseSenderBlock) {
     self.sendMessage(message: messageText, destinationNumber: destinationNumber, sourceNumber: sourceNumber) { (response) in
      if(response?.description == "error") {
        callback([NSNull()])
      }
      else {
        callback([NSNull(), "sucess"])
      }
    }
}
  
func sendMessage(message: String,destinationNumber: String,sourceNumber: String,_ handler:((_ json:JSON?)->Void)?) -> Void {
  
  DispatchQueue.main.async {
  if let conversation = self.cpaas.smsService!.createConversation(fromAddress: sourceNumber, withParticipant: destinationNumber) {
    let msg = self.cpaas.smsService!.createMessage(withText: message)
    conversation.send(message: msg){
      (error, newMessage) in
      if error != nil {
        print("SmsService.send failed. destination: \(String(describing: destinationNumber)). Error desc:\(error!.description)")
        handler?("error")
      } else {
        print("SMS message sent to \(String(describing: destinationNumber))!")
        handler?("Sucess")
      }
    }
  }else{
    print("SmsService.send failed.")
    handler?("error")
  }
}
}
  
  func inboundMessageReceived(message: CPInboundMessage) {
    print("message recived");
    sendEvent(withName: "messageReceived", body: ["message": message.description])
  }
  
  func deliveryStatusChanged(status: CPMessageStatus) {
        print("status",status);
  }
  
  func outboundMessageSent(message: CPOutboundMessage) {
       print("status");
  }

  override func supportedEvents() -> [String]! {
     return ["messageReceived"]
   }
  
}
