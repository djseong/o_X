//
//  OXGameController.swift
//  o_X
//
//  Created by Daniel Seong on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class OXGameController: NSObject {
    static var sharedInstance = OXGameController ()
    private var currentgame = OXGame()
    var ID: Int = 0
    var host: String = "host"
    
    func getCurrentGame () -> OXGame {
        return currentgame
    }
    
    func restartGame(){
        currentgame.reset()
    }
    
    func playMove(x:Int) {
        currentgame.playMove(x)
    }
    
    func getGames(onCompletion onCompletion: ([OXGame]?, String?) -> Void) {
        var dummydata = OXGame()
        onCompletion ([dummydata], "testing")
    }
}