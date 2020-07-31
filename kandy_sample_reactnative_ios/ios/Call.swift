
import  Foundation
import  CPaaSSDK
import UIKit
import Alamofire
import SwiftyJSON
import  CPaaSSDK
import AVFoundation


@objc(Call)

class Call: RCTViewManager,CPCallApplicationDelegate {
  
  var cpaas: CPaaS!
  var currentIncomingCall: CPIncomingCallDelegate!
  let videoView = CallView()

  @objc func initCallModule(_ callback:@escaping RCTResponseSenderBlock) {
     DispatchQueue.main.async {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.cpaas = appDelegate.cpassObj
        callback([NSNull(),"sucess"])
    }
  }
  
  @objc func endCall(_ callback:@escaping RCTResponseSenderBlock) {
      DispatchQueue.main.async {
         if (self.currentIncomingCall != nil){
          self.currentIncomingCall.endCall()
              callback([NSNull(),"sucess"])
         } else {
              callback([NSNull(),"error"])
        }
     }
   }
  
  @objc func setOutGoingCall(_ destinationNumber: String,callback:@escaping RCTResponseSenderBlock) {
    let term = CPUriAddress(username: "nesonukuv", withDomain: "nesonukuv.34mv.att.com")
    self.cpaas.callService?.callApplicationDelegate = self
    let service = self.cpaas.callService
    service?.createOutGoingCall(self, andTerminator: term, completion: { (call, error) in
        if let error = error {
            print("Call Couldn't be created - Error: \(error.localizedDescription)")
            return
        }
        call?.establishCall(true)
    })
    
    
    
//         let service = self.cpaas.callService
//         let destAddress = destinationNumber.components(separatedBy: "@")
//         let destUserId: String = destAddress[0]
//         let destDomain: String = destAddress[1]
//         let term = CPUriAddress(username: destUserId, withDomain: destDomain)
//         service?.createOutGoingCall(self, andTerminator: term, completion: { (call, error) in
//             if let error = error {
//                 print("Call Couldn't be created - Error: \(error.localizedDescription)")
//                 return
//             }
//             call?.establishCall(true)
//              if (call != nil){
//
//                        self.videoView.localView.frame =  CGRect(x:self.videoView.frame.width / 2, y: 0, width:self.videoView.frame.width / 2, height:self.videoView.frame.height)
//                             self.videoView.bringSubviewToFront(self.videoView.localView)
//
//                        self.videoView.remoteView.frame =  CGRect(x:0, y: 0, width:self.videoView.frame.width / 2, height:self.videoView.frame.height)
//                             self.videoView.bringSubviewToFront(self.videoView.remoteView)
//
//                     call?.localVideoView = self.videoView.localView
//                     call?.remoteVideoView = self.videoView.remoteView
//                     callback([NSNull(),"sucess"])
//              } else {
//                callback([NSNull(),"fail"])
//              }
//         })
  }
  
  @objc func unmuteCall(_ callback:@escaping RCTResponseSenderBlock) {
      DispatchQueue.main.async {
         if (self.currentIncomingCall != nil){
          self.currentIncomingCall.unMute()
              callback([NSNull(),"sucess"])
         } else {
              callback([NSNull(),"error"])
        }
     }
  }
  
  @objc func muteCall(_ callback:@escaping RCTResponseSenderBlock) {
      DispatchQueue.main.async {
         if (self.currentIncomingCall != nil){
          self.currentIncomingCall.mute()
              callback([NSNull(),"sucess"])
         } else {
              callback([NSNull(),"error"])
        }
     }
   }
  
  @objc func holdCall(_ callback:@escaping RCTResponseSenderBlock) {
      DispatchQueue.main.async {
         if (self.currentIncomingCall != nil){
          self.currentIncomingCall.holdCall()
              callback([NSNull(),"sucess"])
         } else {
              callback([NSNull(),"error"])
        }
     }
   }
  
  @objc func unholdCall(_ callback:@escaping RCTResponseSenderBlock) {
       DispatchQueue.main.async {
          if (self.currentIncomingCall != nil){
           self.currentIncomingCall.unHoldCall()
               callback([NSNull(),"sucess"])
          } else {
               callback([NSNull(),"error"])
         }
      }
    }
  
  override func view() -> UIView! {
    return videoView
  }
  
  func rejectCall() {
    if (self.currentIncomingCall != nil){
             currentIncomingCall.rejectCall()
    }
  }
  
  func acceptCall() {
    if (self.currentIncomingCall != nil){
             currentIncomingCall.acceptCall(true)
       
              self.videoView.localView.frame =  CGRect(x:self.videoView.frame.width / 2, y: 0, width:self.videoView.frame.width / 2, height:self.videoView.frame.height)
                   self.videoView.bringSubviewToFront(self.videoView.localView)
             
              self.videoView.remoteView.frame =  CGRect(x:0, y: 0, width:self.videoView.frame.width / 2, height:self.videoView.frame.height)
                   self.videoView.bringSubviewToFront(self.videoView.remoteView)
       
             self.currentIncomingCall.localVideoView = self.videoView.localView
             self.currentIncomingCall.remoteVideoView = self.videoView.remoteView
       }
  }
  
  func incomingCall(_ call: CPIncomingCallDelegate) {
    self.currentIncomingCall = call
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let alert = UIAlertController(title: "Incoming Call Received?", message: "Please chosse the action.", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Pick the call.", style: .default, handler: { action in
    self.acceptCall()}))
    alert.addAction(UIAlertAction(title: "Reject the call", style: .cancel, handler: { action in
    self.rejectCall()}))
    appDelegate.window.rootViewController?.present(alert, animated: true)
  }
  
  func callStatusChanged(_ call: CPCallDelegate, with callState: CPCallState) {
    
  }
  
  func callAdditionalInfoChanged(_ call: CPCallDelegate, with detailedInfo: [AnyHashable : Any]) {
    
  }
  
  func mediaAttributesChanged(_ call: CPCallDelegate, with mediaAttributes: CPMediaAttributes) {
    
  }
  
  func establishCallSucceeded(_ call: CPOutgoingCallDelegate) {
    
  }
  
  func establishCallFailed(_ call: CPOutgoingCallDelegate, withError error: CPError) {
    
  }
  
  func acceptCallSucceed(_ call: CPIncomingCallDelegate) {
    
  }
  
  func acceptCallFailed(_ call: CPIncomingCallDelegate, withError error: CPError) {
    
  }
  
  func rejectCallSuccedded(_ call: CPIncomingCallDelegate) {
    
  }
  
  func rejectCallFailed(_ call: CPIncomingCallDelegate, withError error: CPError) {
    
  }
  
  func ignoreSucceed(_ call: CPCallDelegate) {
    
  }
  
  func ignoreFailed(_ call: CPCallDelegate, withError error: CPError) {
    
  }
  
  func endCallSucceeded(_ call: CPCallDelegate) {
    
  }
  
  func endCallFailed(_ call: CPCallDelegate, withError error: CPError) {
    
  }
  
  func muteCallSucceed(_ call: CPCallDelegate) {
    
  }
  
  func muteCallFailed(_ call: CPCallDelegate, withError error: CPError) {
    
  }
  
  func unMuteCallSucceed(_ call: CPCallDelegate) {
    
  }
  
  func unMuteCallFailed(_ call: CPCallDelegate, withError error: CPError) {
    
  }
  
  func videoStartSucceed(_ call: CPCallDelegate) {
    
  }
  
  func videoStartFailed(_ call: CPCallDelegate, withError error: CPError) {
    
  }
  
  func videoStopSucceed(_ call: CPCallDelegate) {
    
  }
  
  func videoStopFailed(_ call: CPCallDelegate, withError error: CPError) {
    
  }
  
  func holdCallSucceed(_ call: CPCallDelegate) {
    
  }
  
  func holdCallFailed(_ call: CPCallDelegate, withError error: CPError) {
    
  }
  
  func unHoldCallSucceed(_ call: CPCallDelegate) {
    
  }
  
  func unHoldCallFailed(_ call: CPCallDelegate, withError error: CPError) {
    
  }
  
  func transferCallSucceed(_ call: CPCallDelegate) {
    
  }
  
  func transferCallFailed(_ call: CPCallDelegate, withError error: CPError) {
    
  }
  
  func forwardCallSucceed(_ call: CPCallDelegate) {
    
  }
  
  func forwardCallFailed(_ call: CPCallDelegate, withError error: CPError) {
    
  }
  
}
