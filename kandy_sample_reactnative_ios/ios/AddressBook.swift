
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
  
  @objc func updateContact(_ jsonObject:NSString,callback:@escaping RCTResponseSenderBlock){
          let jsonText = jsonObject
          var dictonary:NSDictionary?
          if let data = jsonText.data(using: String.Encoding.utf8.rawValue) {
              do {
                dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
              if let contactDictionary = dictonary {
                self.updateContactData(contactDictionary: contactDictionary) { (response) in
                  if(response?.description == "error") {
                           callback([response?.description as Any,"error"])
                    }
                    else {
                         callback([NSNull(), "sucess"])
                  }
                }
              }
              } catch let error as NSError {
                  print(error)
        }
  }
  }

  // In this method we need to update all fields.
   func updateContactData(contactDictionary: NSDictionary,callback:@escaping RCTResponseSenderBlock) {
    let entity = CPContact(contactId: contactDictionary["contactId"]! as! String)
       entity.contactId = contactDictionary["contactId"] as! String
       entity.email = contactDictionary["email"]! as! String
       entity.firstName = contactDictionary["firstName"]! as! String
       entity.lastName = contactDictionary["lastName"]! as! String
       entity.homePhoneNumber = contactDictionary["homePhoneNumber"]! as! String
       entity.businessPhoneNumber = contactDictionary["businessPhoneNumber"]! as! String
       entity.buddy = false
       cpaas.addressBookService?.updateContact(contact: entity, completion: { (error) in
           if let error = error {
               NSLog("Couldn't update the contact to addressbook - Error: \(error.localizedDescription)")
               callback([error.debugDescription,"error"])
           } else {
              NSLog("Contact is updated")
              callback([NSNull(),"sucess"])
           }
       })
   }
  
  override func supportedEvents() -> [String]! {
       return ["messageReceived"]
  }
  
}



