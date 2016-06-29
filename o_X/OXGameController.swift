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
    func getCurrentGame () -> OXGame {
        return currentgame
    }
    func restartGame(){
        currentgame.reset()
    }
    func playMove(x:Int) -> CellType {
        return currentgame.playMove(x)
    }
}
