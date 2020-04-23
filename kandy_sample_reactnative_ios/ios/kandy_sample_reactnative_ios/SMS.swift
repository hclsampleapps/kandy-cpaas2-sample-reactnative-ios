
import  Foundation
import  CPaaSSDK
import UIKit
import Alamofire
import SwiftyJSON
import  CPaaSSDK
import AVFoundation


@objc(SMS)

class SMS: NSObject {
  
var cpaas: CPaaS!
  
@objc func sendMessage(_ destinationNumber: String,sourceNumber: String,messageText: String,callback:@escaping RCTResponseSenderBlock) {
  self.sendMessage(message: messageText, destinationNumber: destinationNumber, sourceNumber: sourceNumber) { (response) in
      callback([NSNull(), "sucess"])
  }
}
  
func sendSms(destinationNumber: String,sourceNumber: String,messageText: String,callback: @escaping RCTResponseSenderBlock) {
     self.sendMessage(message: messageText, destinationNumber: destinationNumber, sourceNumber: sourceNumber) { (response) in
        callback([NSNull(), "sucess"])
    }
}
  
func sendMessage(message: String,destinationNumber: String,sourceNumber: String,_ handler:((_ json:JSON?)->Void)?) -> Void {
  
  DispatchQueue.main.async {
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  self.cpaas = appDelegate.cpassObj
  
  if let conversation = self.cpaas.smsService!.createConversation(fromAddress: sourceNumber, withParticipant: destinationNumber) {
    let msg = self.cpaas.smsService!.createMessage(withText: message)
    conversation.send(message: msg){
      (error, newMessage) in
      if error != nil {
        print("SmsService.send failed. destination: \(String(describing: destinationNumber)). Error desc:\(error!.description)")
        handler?("Failure")
      } else {
        print("SMS message sent to \(String(describing: destinationNumber))!")
        handler?("Sucess")
      }
    }
  }else{
    print("SmsService.send failed.")
    handler?("Failure")
  }
}
}

}
