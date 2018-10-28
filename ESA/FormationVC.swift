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
    
    @IBOutlet weak var FormationCV: UICollectionView!
    
    
    var ref: DatabaseReference!
    
    //Sets up an array of Player Models
    var playerNames = [PlayerModel]()
    var playerName = ""
    var playerNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addInteraction(UIDropInteraction(delegate: self))
        FormationCV.dragInteractionEnabled = true
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
                
                self.FormationCV.reloadData()
            }
            
        })
      
    }
    
  
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        // Ensure the drop session has an object of the appropriate type
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session:UIDropSession)->UIDropProposal{
        return UIDropProposal(operation: .move)
    }
    
    func dropInteraction(_ interacton: UIDropInteraction, performDrop session: UIDropSession){
        for dragItem in session.items{
            dragItem.itemProvider.loadObject(ofClass: UIImage.self,completionHandler: {(obj, err) in
            if let err = err{
                print("Failed to load our dragged item:", err)
                return
            }
            guard let draggedImage = obj as? UIImage else
            {return}
            DispatchQueue.main.async{
                let imageView = UIImageView(image: draggedImage)
                self.view.addSubview(imageView)
                imageView.frame = CGRect(x:0, y: 0, width: 50, height: 50)
                
                let centerPoint = session.location(in: self.view)
                imageView.center = centerPoint
            }
        })
    
    }
    }
    
    func textToImage(drawText: NSString, inImage: UIImage, atPoint:CGPoint)->UIImage{
        
        // Setup the font specific variables
        var textColor: UIColor = UIColor.white
        var textFont: UIFont = UIFont(name: "Helvetica Bold", size: 15)!
        
        //Setup the image context using the passed image.
        UIGraphicsBeginImageContext(inImage.size)
        
        //Setups up the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSAttributedStringKey.font: textFont,
            NSAttributedStringKey.foregroundColor: textColor,
            ]
        
        //Put the image into a rectangle as large as the original image.
        inImage.draw(in: CGRect(x:0, y:0, width: inImage.size.width, height: inImage.size.height))
        
        // Creating a point within the space that is as bit as the image.
        var rect: CGRect = CGRect(x:atPoint.x, y:atPoint.y, width:inImage.size.width, height:inImage.size.height)
        
        //Now Draw the text into an image.
        drawText.draw(in: rect, withAttributes: textFontAttributes)
        
        // Create a new image out of the images we have created
        var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //And pass it back up to the caller.
        return newImage
        
    }

}

extension FormationVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection: Int) ->Int{
        return playerNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! FormationCell
        
        
        let players: PlayerModel
        
        players = playerNames[indexPath.item]
        
        cell.playerImage.image = textToImage(drawText: players.PlayerNumber! as NSString, inImage: UIImage(named: "formation.png")!, atPoint: CGPoint(x: 20, y: 20))
        //cell.playerButton.setTitle(players.PlayerName, for: .normal)
        cell.playerLabel.text = players.PlayerName!
        cell.playerLabel.layer.borderColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0).cgColor
        cell.playerLabel.layer.borderWidth = 2.0;
        cell.playerLabel.layer.masksToBounds = true
        cell.playerLabel.layer.cornerRadius = 3
        
        
        let image = UIImage.imageWithLabel(cell.playerLabel!)
        cell.labelImage.image = image
        
        
        
        var size = CGSize(width: 64, height: 64)
        UIGraphicsBeginImageContext(size)
        
        let playerImageSize = CGRect(x: 8, y: 2, width: 50, height: 50)
        let labelImageSize = CGRect(x: 0, y: 46, width: 64, height: 14)
        cell.playerImage.image!.draw(in: playerImageSize)
        
        cell.labelImage.image!.draw(in: labelImageSize, blendMode: .normal, alpha: 1)
        
        var newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
       
        cell.labelImage.isHidden = true
        cell.playerImage.isHidden = true
        cell.playerLabel.removeFromSuperview()
        
        cell.finalImage.image = newImage
        return cell
    }
}

extension FormationVC: UICollectionViewDragDelegate{

    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! FormationCell
        let players: PlayerModel
        players = playerNames[indexPath.item]
        
        cell.playerImage.image = textToImage(drawText: players.PlayerNumber! as NSString, inImage: UIImage(named: "formation.png")!, atPoint: CGPoint(x: 20, y: 20))
        //cell.playerButton.setTitle(players.PlayerName, for: .normal)
        cell.playerLabel.text = players.PlayerName!
        cell.playerLabel.layer.borderColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0).cgColor
        cell.playerLabel.layer.borderWidth = 2.0;
        cell.playerLabel.layer.masksToBounds = true
        cell.playerLabel.layer.cornerRadius = 3
        
        
        let image = UIImage.imageWithLabel(cell.playerLabel!)
        cell.labelImage.image = image
        
        
        
        var size = CGSize(width: 64, height: 64)
        UIGraphicsBeginImageContext(size)
        
        let playerImageSize = CGRect(x: 8, y: 0, width: 50, height: 50)
        let labelImageSize = CGRect(x: 0, y: 46, width: 64, height: 14)
        cell.playerImage.image!.draw(in: playerImageSize)
        
        cell.labelImage.image!.draw(in: labelImageSize, blendMode: .normal, alpha: 1)
        
        var newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        cell.labelImage.isHidden = true
        cell.playerImage.isHidden = true
        cell.playerLabel.removeFromSuperview()
        
        cell.finalImage.image = newImage
        
        guard let final = cell.finalImage.image else { return [] }

        let itemProvider = NSItemProvider(object: final)
        let dragPlayer = UIDragItem(itemProvider: itemProvider)
        dragPlayer.localObject = final
        return [dragPlayer]
    }
}

extension UIImage {
    class func imageWithLabel(_ label: UILabel) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0)
        defer { UIGraphicsEndImageContext() }
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}


