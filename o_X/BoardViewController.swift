//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var newGameButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newGameButton.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var gameObject = OXGame() 
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        print ("New game button pressed")
        restart()
        self.newGameButton.hidden = true
        
    }
    
    func restart() {
        for subview in boardView.subviews {
            if let button = subview as? UIButton {
                button.setTitle ("", forState: .Normal)
                button.enabled = true
            }
        }
        OXGameController.sharedInstance.restartGame()

    }

    @IBAction func ButtonPressed(sender: UIButton) {
        OXGameController.sharedInstance.playMove(sender.tag - 1)
        var buttontype =  String(OXGameController.sharedInstance.getCurrentGame().whoseTurn())
        sender.setTitle(buttontype, forState: UIControlState.Normal)
        sender.enabled = false
        var gstate = OXGameController.sharedInstance.getCurrentGame().state()
        if (gstate == OXGameState.Won)
        {
            var winnerstring = String(OXGameController.sharedInstance.getCurrentGame().whoseTurn()) + " Won"
            print("winner")
            let alert = UIAlertController(title: "Game Over", message: winnerstring, preferredStyle: UIAlertControllerStyle.Alert)
            
            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: {(action) in
                self.newGameButton.hidden = false
                
            })
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
            for subview in boardView.subviews {
                if let button = subview as? UIButton {
                    button.enabled = false
                }
            }
        }
        else if (gstate == OXGameState.Tie)
        {
            print("tie")
            let alert = UIAlertController(title: "Game Over", message: "Tie", preferredStyle: UIAlertControllerStyle.Alert)
            
            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: {(action) in
                self.newGameButton.hidden = false
                
            })
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
            for subview in boardView.subviews {
                if let button = subview as? UIButton {
                    button.enabled = false
                }
            }
        }
    }

    
    @IBAction func logoutaction(sender: UIButton) {
        print ("Logout button pressed.")
        
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            //Get the root view controller of the other storyboard object
            let viewController = storyboard.instantiateInitialViewController()
            //Get the application object
            let application = UIApplication.sharedApplication()
            //Get the window object from the application object
            let window = application.keyWindow
            //Set the rootViewController of the window to the rootViewController of the other storyboard
            window?.rootViewController = viewController
            
        
        
    }

}
