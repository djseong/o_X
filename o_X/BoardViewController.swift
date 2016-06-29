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
    }

    @IBAction func ButtonPressed(sender: UIButton) {
        print(sender.tag)
    }

    
    @IBAction func logoutaction(sender: UIButton) {
        print ("Logout button pressed.")
        
    }

}

