//
//  MainMenuVC.swift
//  ESA
//
//  Created by Tony Fang on 10/26/18.
//  Copyright © 2018 Tony Fang. All rights reserved.
//

import UIKit


class MainMenuVC: UIViewController{
    
    //let menuIcons:[String] = ["calendarIcon","photoIcon","rosterIcon","settingsIcon","gameIcon","statIcon"]
    
    let gray1 = UIColor(red:0.14, green:0.14, blue:0.14, alpha:1.0)
    let gray2 = UIColor(red:0.32, green:0.32, blue:0.32, alpha:1.0)
    let gray3 = UIColor(red:0.37, green:0.37, blue:0.37, alpha:1.0)
    let gray4 = UIColor(red:0.18, green:0.18, blue:0.18, alpha:1.0)
    let gray5 = UIColor(red:0.41, green:0.41, blue:0.41, alpha:1.0)
    let gray6 = UIColor(red:0.23, green:0.23, blue:0.23, alpha:1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    
   
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
