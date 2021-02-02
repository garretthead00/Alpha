//
//  TargetHandler.swift
//  Alpha
//
//  Created by Garrett Head on 1/31/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import Foundation

import UIKit

struct TargetHandler {
    
    var id : ACTIVITY_DATA_IDENTIFIER
    var name : String
    var description : String
    var unit : Unit
    var icon : UIImage
    var value : Double
    var targetType : ActivityType
    
    init(target: UserTarget, name: String, description : String, icon : UIImage, unit: Unit) {
        
        self.name = name
        self.description = description
        self.icon = icon
        self.description = description
        self.unit = unit
        self.id = target.id
        self.targetType = target.targetType!
        self.value = target.value!
    }
}
