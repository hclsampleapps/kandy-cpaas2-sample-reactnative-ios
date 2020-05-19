
import  Foundation
import  CPaaSSDK
import UIKit
import SwiftyJSON

class AddressbookBO: NSObject {
    var contactId: String!
    var primaryContact: String!
    var firstName: String!
    var lastName: String!
    var email: String!
    var homePhoneNumber: String!
    var businessPhoneNumber: String!
    var isBuddy:Bool = false
}

@objc(AddressBook)

class AddressBook: RCTEventEmitter {
  
  var cpaas: CPaaS!
  var arrAddressbook = [AddressbookBO]()
  var myNewDictArray: [Dictionary<String, String>] = []

  @objc func initAddressBookModule(_ callback:@escaping RCTResponseSenderBlock) {
     DispatchQueue.main.async {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.cpaas = appDelegate.cpassObj
        self.fetchContactList { (response) in
          if(response?.description == "error") {
              callback([NSNull()])
            }
            else {
              callback([NSNull(), self.myNewDictArray])
            }
      }
    }
  }
  
  func fetchContactList(callback:@escaping RCTResponseSenderBlock) {
         cpaas.addressBookService?.retrieveContactList(completion: { (error, contactList) in
             if let error = error {
                 NSLog("Couldn't retrieve contact list from addressbook - Error: \(error.localizedDescription)")
                 callback([NSNull(),"error"])
             }
          
             for contact in contactList! {
                 NSLog("Contact: \(contact)")
                 NSLog("Name: \(contact.firstName) \(contact.lastName)")
                 
                 var emptyDic:[String:String] = [:]
                 emptyDic["contactId"] = contact.contactId
                 emptyDic["firstName"] = contact.firstName
                 emptyDic["lastName"] = contact.lastName
                 emptyDic["email"] = contact.email
                 emptyDic["homePhoneNumber"] = contact.homePhoneNumber
                 emptyDic["businessPhoneNumber"] = contact.businessPhoneNumber
                 self.myNewDictArray.append(emptyDic)
             }
                 callback([NSNull(),self.myNewDictArray])
                 self.myNewDictArray = []
         })
  }

  override func supportedEvents() -> [String]! {
       return ["messageReceived"]
  }
  
}



