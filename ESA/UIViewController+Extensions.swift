//
//  UIViewController+Extensions.swift
//  ESA
//
//  Created by Zachary Frederick on 11/6/18.
//  Copyright © 2018 Tony Fang. All rights reserved.
//

import UIKit
import FirebaseDatabase
import ZAlertView

extension UIViewController {
    
//    func loadDB(){
//        let ref: DatabaseReference!
//        var playerNames = [PlayerModel]()
//
//        ref = Database.database().reference().child("Player")
//
//        //When a new player is added to the database, it is observed and then the player model is added to the playerNames array
//        ref.observe(DataEventType.value, with: {(snapshot) in
//
//            if snapshot.childrenCount > 0{
//                playerNames.removeAll()
//
//                //for all players in the snapshot set the playerName and playerNumber equal to the right things
//                for players in snapshot.children.allObjects as! [DataSnapshot] {
//                    let playerObject = players.value as? [String: AnyObject]
//                    let playerFirstName = playerObject?["PlayerFirstName"]
//                    let playerLastName = playerObject?["PlayerLastName"]
//                    let playerNumber = playerObject?["PlayerNumber"]
//
//                    //Updates the player model with the player name and player number
//                    let player = PlayerModel(PlayerFirstName: playerFirstName as! String , PlayerLastName: playerLastName as! String, PlayerNumber: playerNumber as! String)
//
//                    playerNames.append(player)
//                }
//
//                self.FormationCV.reloadData()
//            }
//
//        })
//    }
    
    func addPlayerAlert() {
        let alertView = ZAlertView(title: "Add New Player", message: "Please Enter Player Name and Number", alertType: .alert)
        
        alertView.addTextField("PlayerFirstName", placeHolder: "Player First Name")
        alertView.addTextField("PlayerLastName", placeHolder: "Players Last Name")
        alertView.addTextField("PlayerNumber", placeHolder: "Players Number")
        
        
        
        self.present(alertView, animated: true, completion: nil)
    }
}
