//
//  RosterVC.swift
//  ESA
//
//  Created by Zachary Frederick on 10/26/18.
//  Copyright © 2018 Tony Fang. All rights reserved.
//

import UIKit

class RosterViewController: UIViewController {
    
    @IBOutlet weak var rosterSearchBar: UISearchBar!
    @IBOutlet weak var rosterTableView: UITableView!
    @IBOutlet weak var addPlayerButton: UIBarButtonItem!
    
    var playerNames = ["Zach","Tony","Danny"]
    var playerName = ""
    var playerNumber = ""
    
    //Search Criteria for the search bar
    var searchCriteria = [String]()
    
    //Will change if the user is searching by name
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if searching {
            cell?.textLabel?.text = searchCriteria[indexPath.row]
        }else {
            cell?.textLabel?.text = playerNames[indexPath.row]
        }
        return cell!
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

//Controls the Search Bar in the Roster Screen
extension RosterViewController: UISearchBarDelegate {
    //Searches the players names as the user types in letters
    //Displays the results after each letter
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCriteria = playerNames.filter({$0.prefix(searchText.count) == searchText})
        
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


extension RosterViewController {
    func addPlayerDialogBox() {
        let alertControler = UIAlertController(title: "Add New Player", message: "Enter Player Name and Number", preferredStyle: .alert)
        
        alertControler.addTextField{(textField) in textField.placeholder = "Enter Player Name"}
        
        alertControler.addTextField{(textField) in textField.placeholder = "Enter Player Number"}
        
        let confirmAction = UIAlertAction(title: "Enter", style: .default, handler: { action in
            
            self.playerName = alertControler.textFields?[0].text ?? "Nothing Entered"
            
            self.playerNumber = alertControler.textFields?[1].text ?? "Nothing Entered"
            
            if(self.playerName != "") {
                self.playerNames.append(self.playerName)
                self.rosterTableView.reloadData()
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
            alertControler.addTextField{(textField) in textField.placeholder = "Enter Player Name"}
            
            alertControler.addTextField{(textField) in textField.placeholder = "Enter Player Number"}
            
        }
        
        alertControler.addAction(confirmAction)
        alertControler.addAction(cancelAction)
        
        self.present(alertControler, animated: true, completion: nil)
    }
}
