//
//  ActivityViewModel.swift
//  Alpha
//
//  Created by Garrett Head on 12/9/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

class ActivityViewModel {
    
    var name : String
    var color : UIColor
    var icon : UIImage
    var target : Double
    var progress : Double
    var remaining : Double {
        let value = target - progress
        return value > 0.0 ? value : 0.0
    }
    var unit : String?
    
    init(activity: Activity, target: UserTarget) {
        self.name = activity.name
        self.color = activity.color
        self.icon = activity.icon
        self.target = target.value as! Double
        self.unit = target.unit
        self.progress = activity.progress ?? 0.0
        
    }
    
}
