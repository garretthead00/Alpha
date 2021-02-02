//
//  HydrationViewModel.swift
//  Alpha
//
//  Created by Garrett Head on 12/17/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

class HydrationViewModel {
    
    var progress : Double
    var target : Double
    var remaining : Double {
        let value = target - progress
        return value > 0.0 ? value : 0.0
    }
    var percentProgress : Double {
        return target > 0 ? progress / target * 100 : 0.0
    }
    var unit : String?
    
    
    init(activity: HydrationActivity, target: UserTarget){
        self.progress = activity.progress ?? 0.0
        self.target = target.value!
        self.unit = "target.unit"
    }
    
    init(handler: ActivityDataHandler, ofUnit unit: Unit, target: UserTarget){
        let unitConverter = UnitConverter()
        self.progress = unitConverter.convert(value: handler.total, toUnit: unit, fromUnit: handler.unit)
        self.unit = unit.symbol
        if let targetValue = target.value { self.target = unitConverter.convert(value: targetValue, toUnit: unit, fromUnit: handler.unit) }
        else { self.target = 0.0 }
    }
}
