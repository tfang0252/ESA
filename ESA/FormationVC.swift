//
//  FormationVC.swift
//  ESA
//
//  Created by Tony Fang on 10/27/18.
//  Copyright © 2018 Tony Fang. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FormationVC: UIViewController,UIDropInteractionDelegate{
    
    
    
    @IBOutlet weak var myUIView: UIView!
    
    let items = ["tony","juan","zach","danny","dani"]
    
    var ref: DatabaseReference!
    
    //Sets up an array of Player Models
    var playerNames = [PlayerModel]()
    var playerName = ""
    var playerNumber = ""
    
    var names = [String]()
    var nums = [String]()
    
    private lazy var button: UIButton = {
        let minimumTappableHeight: CGFloat = 44
        let button = UIButton(frame: CGRect(x: 0, y: 0,
                                            width: minimumTappableHeight,
                                            height: minimumTappableHeight))
        button.center = self.view.center
        button.layer.cornerRadius = minimumTappableHeight / 2
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.yellow
        //let testImage = UIImage(named: "LoginBG.png")
        //button.setBackgroundImage(testImage, for: .normal)
        button.setTitle("❌", for: .normal)
        button.setTitle("⭕️", for: .highlighted)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        ref = Database.database().reference().child("Player")
        
        //When a new player is added to the database, it is observed and then the player model is added to the playerNames array
        ref.observe(DataEventType.value, with: {(snapshot) in
            
            if snapshot.childrenCount > 0{
                self.playerNames.removeAll()
                
                //for all players in the snapshot set the playerName and playerNumber equal to the right things
                for players in snapshot.children.allObjects as! [DataSnapshot] {
                    let playerObject = players.value as? [String: AnyObject]
                    let playerName = playerObject?["PlayerName"]
                    let playerNumber = playerObject?["PlayerNumber"]
                    
                    //Updates the player model with the player name and player number
                    let player = PlayerModel(PlayerName: playerName as! String?, PlayerNumber: playerNumber as! String?)
                    
                    self.playerNames.append(player)
                    self.names.append(player.PlayerName!)
                    self.nums.append(player.PlayerNumber!)
                }
            }
        })
        print(names)
        
        createButtons()
        
        
        //myUIView.addSubview(button)
    }
    
    @objc func drag(control: UIControl, event: UIEvent) {
        if let center = event.allTouches?.first?.location(in: self.myUIView) {
            control.center = center
        }
    }
    
    func createButtons(){
        var buttonX: CGFloat = 20
        var buttonY: CGFloat = 625
        for name in items{
           
            let playerButton = UIButton(frame: CGRect(x: buttonX, y: buttonY,
                                                width: 45,
                                                height: 45))
            buttonX = buttonX+55
            
            playerButton.layer.masksToBounds = true
            
            playerButton.backgroundColor = UIColor.yellow
            playerButton.setTitle(name, for: .normal)
            playerButton.setTitleColor(.red, for: .normal)
            //let testImage = UIImage(named: "LoginBG.png")
            //button.setBackgroundImage(testImage, for: .normal)
            playerButton.layer.cornerRadius = 22
            //playerButton.setTitle("❌", for: .normal)
           // playerButton.setTitle("⭕️", for: .highlighted)
            playerButton.addTarget(self,
                             action: #selector(drag(control:event:)),
                             for: UIControlEvents.touchDragInside)
            playerButton.addTarget(self,
                             action: #selector(drag(control:event:)),
                             for: [UIControlEvents.touchDragExit,
                                   UIControlEvents.touchDragOutside])
            myUIView.addSubview(playerButton)
        }
        

        
    }
    
}




