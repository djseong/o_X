//
//  UserController.swift
//  o_X
//
//  Created by Daniel Seong on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class UserController {
    static var sharedInstance = UserController()
    var currentUser: User?
    private var users: [User] = []
    
    func register(email: String, password: String, onCompletion: (User?, String?) -> Void) {
        
        if (password.characters.count < 6) {
            onCompletion(nil, "Password is less than 6 characters long.")
            return
        }
        
        if (users.contains({ $0.email == email })) {
            onCompletion(nil, "This email is taken.")
            return
        }

        currentUser = User(email: email, password: password)
        onCompletion(currentUser!, nil)
        users.append(currentUser!)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(email, forKey: "currentuseremail")
        defaults.setObject(password, forKey: "currentuserpassword")
        defaults.synchronize()

    }
    
    func login (email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        
        for user in users {
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
        
        onCompletion(nil, "wrong username and password")
        
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
