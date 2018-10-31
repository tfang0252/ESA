//
//  PlayerModel.swift
//  ESA
//
//  Created by Zachary Frederick on 10/26/18.
//  Copyright © 2018 Tony Fang. All rights reserved.
//
class PlayerModel {
    
    var PlayerFirstName: String?
    var PlayerLastName: String?
    var PlayerNumber: String?
    
    init(PlayerFirstName:String?, PlayerLastName:String?, PlayerNumber:String?) {
        self.PlayerFirstName = PlayerFirstName
        self.PlayerLastName = PlayerLastName
        self.PlayerNumber = PlayerNumber
    }
}
