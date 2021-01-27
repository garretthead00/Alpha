//
//  TargetActivityViewModel.swift
//  Alpha
//
//  Created by Garrett Head on 12/11/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

class ActivityTargetDataViewModel {
    
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
    
    
    init(handler: ActivityDataHandler, color: UIColor) {
        self.name = handler.name
        self.icon = handler.icon
        self.unit = handler.unit.symbol
        self.color = color
        self.targetValue = handler.target!.value!
        let percent = handler.target!.value! > 0 ? (handler.progress! / (handler.target!.value!)) * 100 : 0.0
        self.percentComplete = percent
        self.progress = handler.total
    }
    
    init(handler: ActivityDataHandler, ofUnit unit: Unit, withColor color: UIColor){
        self.name = handler.name
        self.icon = handler.icon
        self.color = color
        if let targetValue = handler.target!.value {
            let unitConverter = UnitConverter()
            let percent = targetValue > 0 ? (handler.progress! / (targetValue)) * 100 : 0.0
            self.percentComplete = percent
            self.targetValue = unitConverter.convert(value: targetValue, toUnit: unit, fromUnit: handler.unit)
            self.progress = unitConverter.convert(value: handler.total, toUnit: unit, fromUnit: handler.unit)
            self.unit = unit.symbol
        } else {
            print("no conversion of value. \(handler.name)")
            self.targetValue = 0.0
            self.unit = handler.unit.symbol
            self.percentComplete = 0.0
            self.progress = handler.total
        }
    }
}
