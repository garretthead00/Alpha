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
    var progress : Double
    var remaining : Double
    var unit : String?
    var target : Double?
    
    init(activity: Activity) {
        self.name = activity.name
        self.color = activity.color
        self.icon = activity.icon
        self.progress = activity.progress ?? 0.0
        let handler = activity.getHandler(withIdentifier: activity.progressIdentifier)
        self.unit = handler?.unit.symbol
        self.remaining = handler?.remaining ?? 0.0
        self.target = handler?.target?.value
    }
    
    init(activity: Activity, withUnit unit: Unit) {
        self.name = activity.name
        self.color = activity.color
        self.icon = activity.icon
        self.unit = unit.symbol
        if let handler = activity.getHandler(withIdentifier: activity.progressIdentifier) {
            let unitConverter = UnitConverter()
            let target = unitConverter.convert(value: handler.target!.value!, toUnit: unit, fromUnit: handler.unit)
            let total = unitConverter.convert(value: handler.total, toUnit: unit, fromUnit: handler.unit)
            let remaining = target - total
            self.target = target
            self.progress = total
            self.remaining = remaining
        } else {
            self.target = 0.0
            self.progress = 0.0
            self.remaining = 0.0
        }
        
        
    }
    
    
}
