
import  Foundation
import  CPaaSSDK
import UIKit
import SwiftyJSON

@objc(AddressBook)

class AddressBook: RCTEventEmitter {
  
  var cpaas: CPaaS!

  @objc func initAddressBookModule(_ callback:@escaping RCTResponseSenderBlock) {
     DispatchQueue.main.async {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.cpaas = appDelegate.cpassObj
        callback([NSNull(),"sucess"])
    }
  }

  override func supportedEvents() -> [String]! {
       return ["messageReceived"]
  }
  
}



