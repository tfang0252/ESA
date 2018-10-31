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
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height-55
        
        let window = UIApplication.shared.keyWindow
        let topPadding = (window?.safeAreaInsets.top)!+55
        
        //let navBar = UINavigationBar(frame: CGRect(x: 0, y: topPadding-55, width: screenWidth, height: 55))
        
        let calendarBTN = UIButton(frame: CGRect(x: 0, y: topPadding, width: screenWidth/2, height: screenHeight/3))
        calendarBTN.backgroundColor = gray1
        calendarBTN.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        calendarBTN.setImage(UIImage(named: "calendarIcon.png"), for: .normal)
        
        let gameBTN = UIButton(frame: CGRect(x: screenWidth/2, y: topPadding, width: screenWidth/2, height: screenHeight/3))
        gameBTN.backgroundColor = gray2
        gameBTN.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        gameBTN.setImage(UIImage(named: "gameIcon.png"), for: .normal)
        
        
        let rosterBTN = UIButton(frame: CGRect(x: 0, y: topPadding+screenHeight/3, width: screenWidth/2, height: screenHeight/3))
        rosterBTN.backgroundColor = gray3
        rosterBTN.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        rosterBTN.setImage(UIImage(named: "rosterIcon.png"), for: .normal)
        
        let statBTN = UIButton(frame: CGRect(x: screenWidth/2, y: topPadding+screenHeight/3, width: screenWidth/2, height: screenHeight/3))
        statBTN.backgroundColor = gray4
        statBTN.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        statBTN.setImage(UIImage(named: "statIcon.png"), for: .normal)
        
        let photoBTN = UIButton(frame: CGRect(x: 0, y: topPadding+2*screenHeight/3, width: screenWidth/2, height: screenHeight/3))
        photoBTN.backgroundColor = gray5
        photoBTN.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        photoBTN.setImage(UIImage(named: "photoIcon.png"), for: .normal)
        
        let settingsBTN = UIButton(frame: CGRect(x: screenWidth/2, y: topPadding+2*screenHeight/3, width: screenWidth/2, height: screenHeight/3))
        settingsBTN.backgroundColor = gray6
        settingsBTN.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        settingsBTN.setImage(UIImage(named: "settingsIcon.png"), for: .normal)
        
        
        
        
        //self.view.addSubview(navBar)
        self.view.addSubview(calendarBTN)
        self.view.addSubview(gameBTN)
        self.view.addSubview(rosterBTN)
        self.view.addSubview(statBTN)
        self.view.addSubview(photoBTN)
        self.view.addSubview(settingsBTN)
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
