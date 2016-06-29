//
//  OXGame.swift
//  o_X
//
//  Created by Daniel Seong on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class OXGame {
    private var board = [CellType.Empty,CellType.Empty,CellType.Empty,CellType.Empty,CellType.Empty,CellType.Empty,CellType.Empty,CellType.Empty,CellType.Empty]
    private var startType = CellType.X
    var turn = 0
    var turntype = CellType.X
    
    func turnCount () -> Int {
        return turn;
    }
    
    func whoseTurn ()-> CellType {
        if (self.turntype == CellType.X) {
            self.turntype = CellType.O
            return CellType.X
        }
        else {
            self.turntype = CellType.X
            return CellType.O
        }
    }
    
    func playMove(x:Int) -> CellType {
        board[x] = turntype
        turn += 1
        return turntype;
    }

    func gameWon () -> Bool {
        print (self.board);
        if ((board[0], board[1]) == (board[1],board[2]) && board[0] != CellType.Empty
            || (board[0],board[3]) == (board[3], board[6]) && board[0] != CellType.Empty
            || (board[0], board[4]) == (board[4], board[8]) && board[0] != CellType.Empty
            || (board[4],board[3]) == (board[3], board[5]) && board[4] != CellType.Empty
            || (board[4], board[6]) == (board[6], board[2]) && board[4] != CellType.Empty
            || (board[4], board[1]) == (board[1], board[7]) && board[4] != CellType.Empty
            || (board[2], board[5]) == (board[5], board[8]) && board[2] != CellType.Empty
            || (board[8], board[7]) == (board[7], board[6]) && board[8] != CellType.Empty)
        {
            return true
        }
        else {
        return false
        }
    }
    
    func state() -> OXGameState {
        if (gameWon()) {
            return OXGameState.Won
        }
        else if (turnCount() == 9) {
            return OXGameState.Tie
        }
        else {
            return OXGameState.InProgress
        }
    }
    
    func reset() {
        turn = 0;
        board = [CellType.Empty,CellType.Empty,CellType.Empty,CellType.Empty,CellType.Empty,CellType.Empty,CellType.Empty,CellType.Empty,CellType.Empty];
    }
    
}

enum CellType : String {
    case O = "O"
    case X = "X"
    case Empty = ""
}

enum OXGameState {
    case InProgress
    case Tie
    case Won
    
}