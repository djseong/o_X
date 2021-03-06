//
//  RegisterViewController.swift
//  o_X
//
//  Created by Daniel Seong on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var emailtextfield: UITextField!

    @IBOutlet weak var passwordtextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailtextfield.becomeFirstResponder()
        
        emailtextfield.delegate = self
        passwordtextfield.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == emailtextfield{
            passwordtextfield.becomeFirstResponder()
        }
        else if textField == passwordtextfield{
            passwordtextfield.resignFirstResponder()
        }
        return true
    }
    
    
    @IBAction func registerbuttonpressed(sender: UIButton) {
        UserController.sharedInstance.register(self.emailtextfield.text!, password: self.passwordtextfield.text!, onCompletion: {(u, s) in if ((s) != nil) {
                let alert = UIAlertController(title: "Error", message: s! , preferredStyle: UIAlertControllerStyle.Alert)
                let alertAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                alert.addAction(alertAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //Get the root view controller of the other storyboard object
            let viewController = storyboard.instantiateInitialViewController()
            //Get the application object
            let application = UIApplication.sharedApplication()
            //Get the window object from the application object
            let window = application.keyWindow
            //Set the rootViewController of the window to the rootViewController of the other storyboard
            window?.rootViewController = viewController

            }})
    }
    

 

}
