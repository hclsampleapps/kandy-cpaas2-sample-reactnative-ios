//
//  Chat.swift
//  kandy_sample_reactnative_ios
//
//  Created by Viviksha on 22/04/20.
//


import  Foundation
import  CPaaSSDK
import UIKit
import Alamofire
import SwiftyJSON
import  CPaaSSDK
import AVFoundation


@objc(Chat)

class Chat: NSObject {

  var cpaas: CPaaS!

  @objc func sendChat(_ destinationId: String,messageText: String,callback:@escaping RCTResponseSenderBlock) {
    self.sendChatMessageToCpass(destinationId: destinationId, message: messageText) { (response) in
        callback([NSNull(), response ?? "sucess"])
    }
  }

  func sendChatMessageToCpass(destinationId: String,message: String,callback:@escaping RCTResponseSenderBlock) {
      DispatchQueue.main.async {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      self.cpaas = appDelegate.cpassObj

       if let conversation = self.cpaas.chatService!.createConversation(withParticipant: destinationId) {
           conversation.send(withText: message){
               (error, newMessage) in
               if error != nil {
                   print("ChatService.send failed. destination: \(String(describing: destinationId)). Error desc:\(error!.description)")
                       callback([NSNull(),"error"])
               } else {
                   print("CHAT message sent to \(String(describing: destinationId))!")
                   // save message to application model
                    callback([NSNull(),"sucess"])
               }
           }
           
       } else{
           print("ChatService.send failed.")
          callback([NSNull(),"error"])
       }
    }
  }
}
