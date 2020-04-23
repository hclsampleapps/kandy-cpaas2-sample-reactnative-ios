
import  Foundation
import  CPaaSSDK
import UIKit
import Alamofire
import SwiftyJSON

class LoginModel: NSObject {
  var clientId:String?
  var emailId:String?
  var password:String?
  
}

@objc(login)

class login: NSObject {
  
  private var sessionManager = Alamofire.SessionManager()
  
  var access_token : String = ""
  var cpaas: CPaaS!
  var idToken : String!
  var accessToken : String!
  var lifeTime : Int = 3600
  var channelInfo : String!
  
  var authentication: CPAuthenticationService {
    get {
      return self.cpaas.authenticationService
    }
  }
  
  @objc(loginInApp:password:email:url:callback:)
      
  func loginInApp(_ name: String,password: String,email: String,url: String,callback: @escaping RCTResponseSenderBlock) {

        let model = LoginModel()
        model.clientId = name
        model.emailId = email
        model.password =  password
    
    self.loginUser(object: model) { (response) in
      if(response != nil) {
         self.access_token = (response?["access_token"].stringValue)!
         callback([NSNull(), self.access_token])
      } else {
         callback([NSNull(), "error"])
      }
    }
    
  }
    
  // LOGIN
  func loginUser(object: LoginModel,  _ handler:((_ json:JSON?)->Void)?) -> Void
  {
    let urlString = "https://oauth-cpaas.att.com/cpaas/auth/v1/token"
    let parameters: Parameters = [
      "client_id"      : object.clientId ?? "",
      "username"       : object.emailId ?? "",
      "password"       : object.password ?? "",
      "grant_type"     : "password",
      "scope"          : "openid",
    ]
    
    let headers: HTTPHeaders = [
      "Content-Type": "application/x-www-form-urlencoded"
    ]
    
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 30
    self.sessionManager = Alamofire.SessionManager(configuration: configuration)
    self.sessionManager.request(urlString, method: .post, parameters: parameters,encoding: URLEncoding.default, headers: headers).responseJSON { (dataResponse) in
      print("POSTApi statuscode : ",dataResponse.response?.statusCode ?? "")
      self.sessionManager.session.invalidateAndCancel()
      guard dataResponse.result.isSuccess else {
        let error = dataResponse.result.error!
        print("POSTApi Error : ",error.localizedDescription)
        handler?("error")
        return
      }
      if dataResponse.result.value != nil {
        let json = JSON.init(dataResponse.result.value!)
        print(json)
        if dataResponse.response?.statusCode == 200 {
          handler?(json)
          self.idToken = json["id_token"].stringValue
          self.accessToken = json["access_token"].stringValue
          self.setConfig()
          self.subscribeServices()
          self.setToken()
        }
        return
      }
      handler?("error")
    }
  }
  
}


extension login {
  
  func setConfig() {
    let configuration = CPConfig.sharedInstance()
    configuration.restServerUrl = "oauth-cpaas.att.com"  //"nvs-cpaas-oauth.kandy.io"
    configuration.useSecureConnection = true
  }
  
  func subscribeServices() {
    self.cpaas = CPaaS(services:[CPServiceInfo(type: .sms, push: true), CPServiceInfo(type: .chat, push: true),CPServiceInfo(type: .call, push: true), CPServiceInfo(type: .presence, push: false), CPServiceInfo(type: .addressbook, push: true)])
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.cpassObj = self.cpaas
  }
  
  func setToken() {
    
    self.authentication.connect(idToken: self.idToken, accessToken: self.accessToken, lifetime: self.lifeTime) { (error, channelInfo) in
      
      if let error = error {
        DispatchQueue.main.async { () -> Void in
          print(error.localizedDescription)
        }
      } else {
        DispatchQueue.main.async { () -> Void in
          self.channelInfo = channelInfo!
          print("Channel Info " + self.channelInfo)
          // Navigate To Dashboard
        }
      }
    }
  }

}


