//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var networklabel: UILabel!
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var newGameButton: UIButton?
    var networkmode: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newGameButton?.hidden = true
        updateUI()
        if networkmode == true {
            self.networklabel.text = "In progress"
        }
    }
    
    var gameObject = OXGame() 
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        print ("New game button pressed")
        restart()
        self.newGameButton?.hidden = true
        
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
        let buttontype =  String(OXGameController.sharedInstance.getCurrentGame().whoseTurn())
        sender.setTitle(buttontype, forState: UIControlState.Normal)
        sender.enabled = false
        let gstate = OXGameController.sharedInstance.getCurrentGame().state()
        
        if (gstate == OXGameState.InProgress) {
            return
        }
        
        var message = ""
        if (gstate == OXGameState.Won)
        {
            message = buttontype + " Won"
        }
        else {
            message = "Tie"
        }
            let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: {(action) in
                self.newGameButton?.hidden = false })
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
            for subview in boardView.subviews {
                if let button = subview as? UIButton {
                    button.enabled = false
                }
            }
    }
    
    func updateUI() {
        var board = OXGameController.sharedInstance.getCurrentGame().board
        print(board)
        for cell in 0...8 {
            if board[cell] != CellType.Empty {
                if let button = self.view.viewWithTag(cell + 1) as? UIButton {
                    button.setTitle(board[cell].rawValue, forState: .Normal)
                    button.enabled = false
                }
            }
        }
    }

    
    @IBAction func logoutaction(sender: UIButton) {        
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
