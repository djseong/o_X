//
//  OXGame.swift
//  o_X
//
//  Created by Daniel Seong on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class OXGame{
    var board = [CellType](count:9, repeatedValue: CellType.Empty)
    var winnerType = CellType.X
    var turntype = CellType.X
    
    var ID:Int = 0
    var host:String = "" 
    
    init()  {
        //we are simulating setting our board from the internet
        let simulatedBoardStringFromNetwork = "_________" //update this string to different values to test your model serialisation
        self.board = deserialiseBoard(simulatedBoardStringFromNetwork) //your OXGame board model should get set here
        if(simulatedBoardStringFromNetwork == serialiseBoard())    {
            print("start\n------------------------------------")
            print("congratulations, you successfully deserialised your board and serialized it again correctly. You can send your data model over the internet with this code. 1 step closer to network OX ;)")
            
            print("done\n------------------------------------")
        }   else    {
            print("start\n------------------------------------")
            print ("your board deserialisation and serialization was not correct :( carry on coding on those functions")
            
            print("done\n------------------------------------")
        }
        
    }
    
    func deserialiseBoard(b: String) -> [CellType] {
        var tempboard: [CellType] = []
        for letter in b.characters {
            if letter == "o" {
                tempboard.append(CellType.O)
            }
            else if letter == "x" {
                tempboard.append(CellType.X)
            }
            else {
                tempboard.append(CellType.Empty)
            }
        }
        return tempboard
        
    }
    
    func serialiseBoard() -> String {
        var tempstring = ""
        for cell in self.board {
            if cell == CellType.O {
                tempstring += "o"
            }
            else if cell == CellType.X {
                tempstring += "x"
            }
            else {
                tempstring += "_"
            }
        }
        
        return tempstring
    }
    
    func turnCount () -> Int {
        var turn = 0
        for cell in board {
            if cell != CellType.Empty {
                turn += 1
            }
        }
        return turn;
    }
    
    func whoseTurn ()-> CellType {
        if (self.turntype == CellType.X) {
            self.turntype = CellType.O
            self.winnerType = CellType.X
            return CellType.X
        }
        else {
            self.turntype = CellType.X
            self.winnerType = CellType.O
            return CellType.O
        }
        
    }
    
    func playMove(x:Int){
        if (self.state() == OXGameState.InProgress) {
            board[x] = turntype
        }
    }
    
    func undo(x:Int) {
        board[x] = CellType.Empty
    }

    func gameWon () -> Bool {
        //print("current board")
        //print (self.board);
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
        board = [CellType](count:9, repeatedValue: CellType.Empty)
        turntype = CellType.X
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
    case open
    case abandoned
    
}