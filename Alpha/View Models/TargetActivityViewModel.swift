//
//  TargetActivityViewModel.swift
//  Alpha
//
//  Created by Garrett Head on 12/11/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

class TargetActivityViewModel {
    
    var name: String
    var icon : UIImage
    var unit : String
    var color : UIColor
    var targetValue : Double
    var progress : Double
    var percentComplete : Double
    var remaining : Double {
        let value = targetValue - progress
        return value > 0.0 ? value : 0.0
    }
    
    init(target: UserTarget, progress: Double, color: UIColor, isPercent: Bool) {
        self.name = target.name!
        self.icon = target.icon!
        self.unit = target.unit!
        self.color = color
        self.targetValue = target.value!
        let percent = target.value! > 0 ? (progress / (target.value!)) * 100 : 0.0
        self.percentComplete = percent
        self.progress = isPercent ? percent : progress
    }
    
}
