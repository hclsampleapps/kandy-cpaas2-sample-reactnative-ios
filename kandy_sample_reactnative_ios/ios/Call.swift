
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
        self.cpaas.callService?.callApplicationDelegate = self
        callback([NSNull(),"sucess"])
    }
  }
  
  override func view() -> UIView! {
    return videoView
  }
  
  func incomingCall(_ call: CPIncomingCallDelegate) {
      self.currentIncomingCall = call
      if (self.currentIncomingCall != nil){
              currentIncomingCall.acceptCall(true)
        
               self.videoView.localView.frame =  CGRect(x:self.videoView.frame.width / 2, y: 0, width:self.videoView.frame.width / 2, height:self.videoView.frame.height)
                    self.videoView.bringSubviewToFront(self.videoView.localView)
              
               self.videoView.remoteView.frame =  CGRect(x:0, y: 0, width:self.videoView.frame.width / 2, height:self.videoView.frame.height)
                    self.videoView.bringSubviewToFront(self.videoView.remoteView)
        
              call.localVideoView = self.videoView.localView
              call.remoteVideoView = self.videoView.remoteView
        }
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
