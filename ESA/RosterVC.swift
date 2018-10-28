//
//  RosterVC.swift
//  ESA
//
//  Created by Zachary Frederick on 10/26/18.
//  Copyright © 2018 Tony Fang. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RosterViewController: UIViewController {
    
    @IBOutlet weak var rosterSearchBar: UISearchBar!
    @IBOutlet weak var rosterTableView: UITableView!
    @IBOutlet weak var addPlayerButton: UIBarButtonItem!
    
    var ref: DatabaseReference!
    
    //Sets up an array of Player Models
    var playerNames = [PlayerModel]()
    
    var playerName = ""
    var playerNumber = ""
    
    //Search Criteria for the search bar
    var searchCriteria = [PlayerModel]()
    
    //Will change if the user is searching by name
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Database reference to the Player table
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
                }
                
                self.rosterTableView.reloadData()
            }
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //When the add player buttun is pushed, the Add Player alert box is displayed
    @IBAction func addPlayerClicked(_ sender: UIBarButtonItem) {
       addPlayerDialogBox()
    }
    
}

//Controlls the Table View in the Roster Screen
extension RosterViewController: UITableViewDataSource, UITableViewDelegate {
    
    //Adds the correct number of cells to the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            return searchCriteria.count
        }else {
            return playerNames.count
        }
    }
    
    //Populates the cells in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RosterVCTableViewCell
        
        let players: PlayerModel
        
        players = playerNames[indexPath.row]
        
        if searching {
            //NEEDS UPDATED
            //cell.playerNameLbl.text = searchCriteria[indexPath.row]
        }else {
            cell.playerNameLbl.text = players.PlayerName
            cell.playerNumberLbl.text = players.PlayerNumber
        }
        return cell
    }
    
    //Deletes cell in the table view if the user swips
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.playerNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        rosterTableView.reloadData()
    }
}

//Controls the Search Bar in the Roster Screen NEEDS UPDATED
extension RosterViewController: UISearchBarDelegate {
    //Searches the players names as the user types in letters
    //Displays the results after each letter
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//        searchCriteria = playerNames.filter({$0.prefix(searchText.count) == searchText})
        
        searching = true
        rosterTableView.reloadData()
    }
    
    //Deletes search result and returns the table to display all player names
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        rosterTableView.reloadData()
    }
}

//Add player alert box
extension RosterViewController {
    func addPlayerDialogBox() {
        //Creates the new alert box
        let alertControler = UIAlertController(title: "Add New Player", message: "Enter Player Name and Number", preferredStyle: .alert)
        
        //Adds text fields
        alertControler.addTextField{(textField) in textField.placeholder = "Enter Player Name"}
        alertControler.addTextField{(textField) in textField.placeholder = "Enter Player Number"}
        
        //When enter is hit, the player name and player number is saved to the database
        let confirmAction = UIAlertAction(title: "Enter", style: .default, handler: { action in
            
            self.playerName = alertControler.textFields?[0].text ?? "Nothing Entered"
            
            self.playerNumber = alertControler.textFields?[1].text ?? "Nothing Entered"
            
            //If something is entered into the player name box, the database is updated
            if(self.playerName != "") {
                let playerInfo = ["PlayerName": self.playerName, "PlayerNumber": self.playerNumber]
                self.ref.childByAutoId().setValue(playerInfo)
                
                self.rosterTableView.reloadData()
            }
        })
        
        //If the user hits cancel the alertbox disappears
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
            alertControler.addTextField{(textField) in textField.placeholder = "Enter Player Name"}
            
            alertControler.addTextField{(textField) in textField.placeholder = "Enter Player Number"}
            
        }
        
        //Adds buttons to alert box
        alertControler.addAction(confirmAction)
        alertControler.addAction(cancelAction)
        
        self.present(alertControler, animated: true, completion: nil)
    }
}
