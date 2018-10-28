//
//  GameTimerVC.swift
//  ESA
//
//  Created by Zachary Frederick on 10/28/18.
//  Copyright © 2018 Tony Fang. All rights reserved.
//

import FirebaseDatabase
import UIKit

class GameTimerViewController: UIViewController {
    
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var gamePlayerTableView: UITableView!

    var ref: DatabaseReference!
    var teamRoster = [String]()
    var playerName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("Player")
        
        ref.observe(DataEventType.value, with: {(snapshot) in
            
            if snapshot.childrenCount > 0{
                self.teamRoster.removeAll()
                
                //for all players in the snapshot set the playerName and playerNumber equal to the right things
                for players in snapshot.children.allObjects as! [DataSnapshot] {
                    let playerObject = players.value as? [String: AnyObject]
                    let playerName = playerObject?["PlayerName"]
                    
                    
                    self.teamRoster.append(playerName as! String)
                }
                
                self.gamePlayerTableView.reloadData()
            }
        })
        
        print(teamRoster.count)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GameTimerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return teamRoster.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let timerCell = tableView.dequeueReusableCell(withIdentifier: "playerTimerCell", for: indexPath) as! TimerVCTableViewCell
        
        let players: String
        
        players = teamRoster[indexPath.row]
            print(players)
        
            timerCell.playerNameLbl.text = players
        
        return timerCell
    }
}
