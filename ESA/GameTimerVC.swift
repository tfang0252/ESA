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
    
    var seconds = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    @IBOutlet weak var pauseBttn: UIButton!
    @IBOutlet weak var startBttn: UIButton!
    @IBOutlet weak var resetBttn: UIButton!
    
    @IBAction func goalBttnPushed(_ sender: Any) {
        
    }
    
    @IBAction func startBttnPushed(_ sender: Any) {
        self.resetBttn.isEnabled = false
        if isTimerRunning == false {
            runTimer()
            self.startBttn.isEnabled = false
        }
    }
    
    @IBAction func pauseBttnPushed(_ sender: Any) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.resetBttn.isEnabled = true
            self.pauseBttn.setTitle("Resume", for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            self.resetBttn.isEnabled = false
            self.pauseBttn.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func resetBttnPushed(_ sender: Any) {
        timer.invalidate()
        seconds = 0    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
        timerLbl.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        self.pauseBttn.isEnabled = false
        self.pauseBttn.setTitle("Pause", for: .normal)
        self.resumeTapped = false
        self.startBttn.isEnabled = true
        self.resetBttn.isEnabled = false
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pauseBttn.isEnabled = false
        self.resetBttn.isEnabled = false
        
        
        ref = Database.database().reference().child("Player")
        
        ref.observe(DataEventType.value, with: {(snapshot) in
            
            if snapshot.childrenCount > 0{
                self.teamRoster.removeAll()
                
                //for all players in the snapshot set the playerName and playerNumber equal to the right things
                for players in snapshot.children.allObjects as! [DataSnapshot] {
                    let playerObject = players.value as? [String: AnyObject]
                    let playerName = playerObject?["PlayerFirstName"]
                    
                    
                    self.teamRoster.append(playerName as! String)
                }
                
                self.gamePlayerTableView.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//Populates the Cells of the table view
extension GameTimerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return teamRoster.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let timerCell = tableView.dequeueReusableCell(withIdentifier: "playerTimerCell", for: indexPath) as! TimerVCTableViewCell
        
        let players: String
        
        players = teamRoster[indexPath.row]
        
            timerCell.playerNameLbl.text = players
        
        return timerCell
    }
}

extension GameTimerViewController {
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(GameTimerViewController.updateTimer)), userInfo: nil, repeats: true)
        
        isTimerRunning = true
        self.pauseBttn.isEnabled = true
    }

    @objc func updateTimer() {
        seconds += 1     //This will decrement(count down)the seconds.
        timerLbl.text = timeString(time: TimeInterval(seconds))//This will update the label.
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}
