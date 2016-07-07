//
//  UserController.swift
//  o_X
//
//  Created by Daniel Seong on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit
import Alamofire

class UserController: WebService {
    
    static var sharedInstance = UserController()
    var currentUser: User?
    private var users: [User] = []
    
    func register(email: String, password: String, onCompletion: (User?, String?) -> Void) {
        let user = ["email": email, "password": password]
        
        let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth"), method: "POST", parameters: user)
        
        self.executeRequest(request) { (responseCode, json) in
            print(json)
            
            if responseCode / 100 == 2 {
                //let t = json["data"]["email"].stringValue
                var user2 = User(email: json["data"]["email"].stringValue, password: "not given", token: json["data"]["token"].stringValue, client: json["data"]["client"].stringValue)
                self.currentUser = user2
                
                onCompletion(user2, nil)
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(email, forKey: "currentuseremail")
                defaults.setObject(password, forKey: "currentuserpassword")
                defaults.synchronize()
            }
            else {
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                //execute the closure in the ViewController
                onCompletion(nil,errorMessage)
            }
        }
        
        /*if (password.characters.count < 6) {
            onCompletion(nil, "Password is less than 6 characters long.")
            return
        }
        
        if (users.contains({ $0.email == email })) {
            onCompletion(nil, "This email is taken.")
            return
        }

        currentUser = User(email: email, password: password)
        onCompletion(currentUser!, nil)
        users.append(currentUser!)*/
       

    }
    
    func login (email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        
        let user = ["email": email, "password": password]
         let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth/sign_in"), method: "POST", parameters: user)
        self.executeRequest(request) { (responseCode, json) in
            if responseCode / 100 == 2 {
                var user2 = User(email: json["data"]["email"].stringValue, password: "not given", token: json["data"]["token"].stringValue, client: json["data"]["client"].stringValue)
                self.currentUser = user2
                onCompletion(user2, nil)
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(email, forKey: "currentuseremail")
                defaults.setObject(password, forKey: "currentuserpassword")
                defaults.synchronize()
            }
            else {
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                //execute the closure in the ViewController
                onCompletion(nil,errorMessage)
            }
        }
        
        /*for user in users {
            if user.email == email && user.password == password {
                onCompletion(user, nil)
                currentUser = user
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(email, forKey: "currentuseremail")
                defaults.setObject(password, forKey: "currentuserpassword")
                defaults.synchronize()
                return
            }
        }
        
        onCompletion(nil, "wrong username and password")*/
        
    }
    func logout(onCompletion onCompletion: (String?) -> Void) {
        currentUser = nil
        onCompletion(nil)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("currentuseremail")
        defaults.removeObjectForKey("currentuserpassword")
        defaults.synchronize()
    }

}
