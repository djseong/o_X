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
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var gameObject = OXGame() 
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        print ("New game button pressed")
        restart()
        
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
        print(sender.tag)
        OXGameController.sharedInstance.playMove(sender.tag - 1)
        var buttontype =  String(OXGameController.sharedInstance.getCurrentGame().whoseTurn())
        sender.setTitle(buttontype, forState: UIControlState.Normal)
        sender.enabled = false
        var gstate = OXGameController.sharedInstance.getCurrentGame().state()
        if (gstate == OXGameState.Won)
        {
            print("winner")
            restart()
        }
        else if (gstate == OXGameState.Tie)
        {
            print("tie")
            restart()
        }
    }

    
    @IBAction func logoutaction(sender: UIButton) {
        print ("Logout button pressed.")
        
    }

}
