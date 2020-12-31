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
        
        
        switch activity.activityType {
            case .fitness : self.progress = activity.getValue(ofKey: "energyBurned")
            case .nutrition : self.progress = activity.getValue(ofKey: "energyConsumed")
            case .hydration : self.progress = activity.getValue(ofKey: NUTRIENT.Water.rawValue)
            case .sleep : self.progress = activity.getValue(ofKey: "sleepMinutes")
            case .mindfulness : self.progress = activity.getValue(ofKey: "mindfulMinutes")
            default: self.progress = 0.0
        }
        
    }
    
}
