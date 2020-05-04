
import  Foundation
import  CPaaSSDK
import UIKit
import Alamofire
import SwiftyJSON
import  CPaaSSDK
import AVFoundation


@objc(Persence)

class Persence: RCTEventEmitter,CPPresenceDelegate {
  
  var cpaas: CPaaS!
  var presentitylist: CPPresentityList? = nil

  @objc func initPresenceModule(_ callback:@escaping RCTResponseSenderBlock) {
     DispatchQueue.main.async {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.cpaas = appDelegate.cpassObj
        self.cpaas.presenceService?.delegate = self
        callback([NSNull(),"sucess"])
    }
  }
  
  @objc func setPersence(_ currentStatus: String,callback:@escaping RCTResponseSenderBlock) {
        print(currentStatus)
    self.updateStatus(statusToUpdate: currentStatus, callback: { (response) in
        if(response?.description == "error") {
          callback([response?.description as Any,"error"])
        } else {
            callback([NSNull(), "sucess"])
      }
    })
  }
  
  @objc func getPersence(_ subscriberId: String,callback:@escaping RCTResponseSenderBlock) {
    self.checkPersense(subcriberId: subscriberId) { (response) in
            if(response?.description == "error") {
              callback([response?.description as Any,"error"])
            } else {
              callback([NSNull(), response as Any])
          }
    }
  }
  
  func updateStatus(statusToUpdate: String,callback:@escaping RCTResponseSenderBlock) {
       let activityType = CPPresenceActivities(rawValue: statusToUpdate)
       var presenceActivity:PresenceActivity!
       presenceActivity = PresenceActivity(activityType)
       self.cpaas.presenceService?.createPresenceSource(activity: presenceActivity) {
           (error, newPresenceSource) in
           if error ==  nil {
            if (newPresenceSource?.activity.state.rawValue) != nil {
                callback([NSNull(),"error"])
            }
           } else {
               print(error.debugDescription)
               callback([error.debugDescription,"error"])
           }
       }
    
   }
  
  func checkPersense(subcriberId: String,callback:@escaping RCTResponseSenderBlock) {
    self.cpaas.presenceService?.fetchAllPresentityLists { (error, presentityLists) in
            if error == nil, let presentityLists = presentityLists, let foundList = presentityLists.first {
                self.presentitylist = foundList

                // subscribe for updates to this list
                self.presentitylist?.subscribe { (error) in
                    // don't indicate error to application, just print a log
                    if let error = error {
                        print("Failed to subscribe to presentityList \(self.presentitylist?.name ?? "nil"): \(error.localizedDescription)")
                    }
                }
                // Take second step of fetching status for this list
                self.presentitylist?.fetchStatus { (error, presentityStatusList) in
                      callback([NSNull(),presentityStatusList])
                }
            } else {
              callback([NSNull(),"error"])
      }
        }
    
//        let contacts = [subcriberId]
//         self.cpaas.presenceService?.createPresentityList(name: "default", presentities: contacts) {
//             (error, newPresentityList) in
//             if error == nil {
//                 self.presentitylist = newPresentityList
//                 // subscribe for updates to this list
//                 self.presentitylist?.subscribe { (error) in
//                     // don't indicate error to application, just print a log
//                     if let error = error {
//                         print("Failed to subscribe to presentityList \(self.presentitylist?.name ?? "nil"): \(error.localizedDescription)")
//                     }
//                 }
//             } else {
//                 print("Failed to create presentityList \(self.presentitylist?.name ?? "nil"): \(String(describing: error?.localizedDescription))")
//             }
//         }
  }
  
  override func supportedEvents() -> [String]! {
       return ["messageReceived"]
  }
  
  func listChanged(presentityList: CPPresentityList) {
       print("PresentityList",presentityList);
  }
  
  func subscriptionExpired(presentityListHandle: CPPresentityListHandle) {
        print("PresentityListHandle",presentityListHandle);
  }
  
  func statusChanged(presentity: CPPresentity) {
      print("Presentity",presentity);
  }
  
}
