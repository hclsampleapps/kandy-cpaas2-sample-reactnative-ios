
import  Foundation
import  CPaaSSDK
import UIKit
import SwiftyJSON


@objc(Directory)

class Directory: RCTEventEmitter {
  
  var cpaas: CPaaS!
  var myNewDictArray: [Dictionary<String, String>] = []


  @objc func initDirectoryModule(_ callback:@escaping RCTResponseSenderBlock) {
     DispatchQueue.main.async {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.cpaas = appDelegate.cpassObj
    }
  }
  
  override func supportedEvents() -> [String]! {
       return ["messageReceived"]
  }
  
   @objc func searchContactKeyWord(_ jsonObject:NSString,callback:@escaping RCTResponseSenderBlock) {
       let jsonText = jsonObject
            var dictonary:NSDictionary?
            if let data = jsonText.data(using: String.Encoding.utf8.rawValue) {
                do {
                  dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                if let contactDictionary = dictonary {
                      let searchText = contactDictionary["searchText"]! as! String
                  self.searchContactInDirectory(searchText: searchText, selectedFilterKeyType:.name ,selectedOrderType: .ascending, selectedSortType:.name, callback: { (response) in
                      if(response?.description == "error") {
                        callback([response?.description as Any,"error"])
                      } else {
                        callback([NSNull(), self.myNewDictArray])
                        self.myNewDictArray = []
                    }
                  })
                  }
              } catch let error as NSError {
                    print(error)
          }
    }
  }
  
  func searchContactInDirectory(searchText: String, selectedFilterKeyType:CPAddressBook.FieldType,selectedOrderType: CPAddressBook.OrderType, selectedSortType:CPAddressBook.FieldType,callback:@escaping RCTResponseSenderBlock) {
      
      let type = selectedFilterKeyType //name, f-name
      let orderType = selectedOrderType // asscending
      let sortType = selectedSortType //name, f-name
      let max = 50
      
      let searchObj = CPSearch(filter: CPSearchFilter(value: searchText, forType: type))
      searchObj.orderBy = orderType
      searchObj.sortBy = sortType
      searchObj.limit = max
      cpaas.addressBookService?.search(with: searchObj, completion: { (error, searchResult) in
          
      if let error = error {
              NSLog("Couldn't search in directory - Error: \(error.localizedDescription)")
              callback([NSNull(),"error"])
      } else {
            for contact in (searchResult?.contacts!)! {
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
        }
      })
  }
    
}




