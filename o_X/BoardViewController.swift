//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {
    @IBOutlet weak var currentgamelabel: UILabel?
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
            self.currentgamelabel?.text = String(OXGameController.sharedInstance.getCurrentGame().ID)
            
        }
    }
    
    var gameObject = OXGame() 
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        print ("New game button pressed")
        restart()
        self.newGameButton?.hidden = true
        
    }
    
    
    @IBAction func refreshbuttonpressed(sender: UIButton) {
        OXGameController.sharedInstance.viewgame(OXGameController.sharedInstance.getCurrentGame().ID) { (error) in
            if error == nil {
                self.updateUI()
                OXGameController.sharedInstance.getCurrentGame().whoseTurn()
                OXGameController.sharedInstance.getCurrentGame().turnCount()
                self.checkforwin(OXGameController.sharedInstance.getCurrentGame().winnerType.rawValue)
            }
        }
    }
    
    @IBAction func cancelbuttonpressed(sender: UIButton) {
        OXGameController.sharedInstance.cancelgame(OXGameController.sharedInstance.getCurrentGame().ID) { (error) in
            if error == nil {
                self.navigationController?.popViewControllerAnimated(true)
            }
            else {
                let alert = UIAlertController(title: "Game Over", message: error, preferredStyle: UIAlertControllerStyle.Alert)
                let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: {(action) in
                    self.newGameButton?.hidden = false })
                alert.addAction(alertAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
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
    
    func checkforwin (winner:String) {
        let gstate = OXGameController.sharedInstance.getCurrentGame().state()
        
        if (gstate == OXGameState.InProgress) {
            return
        }
        
        var message = ""
        if (gstate == OXGameState.Won)
        {
            message = winner + " Won"
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

    @IBAction func ButtonPressed(sender: UIButton) {
        var buttontype = ""
        OXGameController.sharedInstance.playMove(sender.tag - 1)

        if (self.networkmode == true) {
            print(OXGameController.sharedInstance.getCurrentGame().serialiseBoard())
            OXGameController.sharedInstance.networkplaymove(OXGameController.sharedInstance.getCurrentGame().ID, board: OXGameController.sharedInstance.getCurrentGame().serialiseBoard()) { (error) in
                if error == nil {
                    buttontype =  String(OXGameController.sharedInstance.getCurrentGame().whoseTurn())
                    print("turn move: ")
                    print(buttontype)
                    sender.setTitle(buttontype, forState: UIControlState.Normal)
                    sender.enabled = false
                }
                else {
                    OXGameController.sharedInstance.getCurrentGame().undo(sender.tag - 1)
                    print ("here is internal board")
                    print (OXGameController.sharedInstance.getCurrentGame().serialiseBoard())
                    let alert = UIAlertController(title: "Error", message: error , preferredStyle: UIAlertControllerStyle.Alert)
                    let alertAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                    alert.addAction(alertAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
            }}
            else {
                buttontype =  String(OXGameController.sharedInstance.getCurrentGame().whoseTurn())
                print("turn move: ")
                print(buttontype)
                sender.setTitle(buttontype, forState: UIControlState.Normal)
                sender.enabled = false
            }
                checkforwin(OXGameController.sharedInstance.getCurrentGame().turntype.rawValue)
            }
    
    func updateUI() {
        var board = OXGameController.sharedInstance.getCurrentGame().board
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
