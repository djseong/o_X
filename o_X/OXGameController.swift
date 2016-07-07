//
//  OXGameController.swift
//  o_X
//
//  Created by Daniel Seong on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit
import SwiftyJSON

class OXGameController: WebService {
    static var sharedInstance = OXGameController ()
    private var currentgame = OXGame()
    
    func getCurrentGame () -> OXGame {
        return currentgame
    }
    
    func restartGame(){
        currentgame.reset()
    }
    
    func playMove(x:Int) {
        currentgame.playMove(x)
    }
    
    func cancelgame(id:Int, onCompletion: (String?) -> Void) {
       let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(id)"), method: "DELETE", parameters: nil)
        self.executeRequest(request) { (responseCode, json) in
            if responseCode / 100 == 2 {
                print ("successfully cancelled game")
                self.restartGame()
                self.currentgame = OXGame()
                onCompletion(nil)
            }
            else {
                onCompletion(json["error"].stringValue)
            }
        }
    }
    
    func viewgame(id:Int, onCompletion: (String?) -> Void) {
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(id)"), method: "GET", parameters: nil)
        self.executeRequest(request) { (responseCode, json) in
            if responseCode / 100 == 2 {
                print ("got game")
                var newboard = self.currentgame.deserialiseBoard(json["board"].stringValue)
                self.currentgame.board = newboard
                print("here is got board")
                print(self.currentgame.board)
                onCompletion(nil)
            }
            else {
                print ("could not get game")
            }
        }
    }
    
    func networkplaymove(id:Int, board: String, onCompletion: (String?) -> Void) {
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(id)"), method: "PUT", parameters: ["board": board])
        self.executeRequest(request) { (responseCode, json) in
            if responseCode / 100 == 2 {
                print("played move")
                onCompletion(nil)
            }
            else {
               print ("error playing move")
                print(json)
                onCompletion(json["error"].stringValue)
            }
        }
    }
    
    func joingame(id:Int, onCompletion: (OXGame?, String?) -> Void) {
       let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(id)/join"), method: "GET", parameters: nil)
        self.executeRequest(request) { (responseCode, json) in
            if responseCode / 100 == 2 {
                print ("joined game id: \(json["id"].intValue)")
                var newgame = OXGame()
                newgame.ID = json["id"].intValue
                newgame.host = json["host_user"]["email"].stringValue
                self.currentgame = newgame
                onCompletion(newgame, nil)
            }
        }
    }
    
    func createNewGame(onCompletion onCompletion: (OXGame?, String?) -> Void) {
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "POST", parameters: nil)
        self.executeRequest(request) { (responseCode, json) in
            if responseCode / 100 == 2 {
                print ("create game successfull")
                print(json)
                var newgame = OXGame()
                newgame.ID = json["id"].intValue
                newgame.host = json["host_user"]["email"].stringValue
                self.currentgame = newgame
                onCompletion(newgame, nil)
            }
        }
    }
    
    func getGames(onCompletion onCompletion: ([OXGame]?, String?) -> Void) {
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "GET", parameters: nil)
        self.executeRequest(request) { (responseCode, json) in
            if responseCode / 100 == 2 {
                print("here are games")
                print(json)
                var gamearray: [OXGame] = []
                for (_,jsonGame) in json {
                    let game = OXGame()
                    game.ID = jsonGame["id"].intValue
                    game.host = jsonGame["host_user"]["email"].stringValue
                    gamearray.append(game)
                }
                onCompletion(gamearray, nil)
                
            }
            else {
                onCompletion(nil, "Unable to load games")
            }
        }
        
    }
}