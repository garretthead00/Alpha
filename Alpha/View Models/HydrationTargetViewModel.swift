//
//  HydrationTargetViewModel.swift
//  Alpha
//
//  Created by Garrett Head on 12/31/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

class HydrationTargetViewModel {
    
    var waterDrank : Double
    var targetValue : Double
    var unit : String
    
    init(waterDrank: Double, target: UserTarget) {
        self.waterDrank = waterDrank
        self.targetValue = target.value!
        self.unit = ""
    }
    
    init(handler: ActivityDataHandler, ofUnit unit: Unit, target: UserTarget){
        let unitConverter = UnitConverter()
        self.waterDrank = unitConverter.convert(value: handler.total, toUnit: unit, fromUnit: handler.unit)
        self.unit = unit.symbol
        if let targetValue = target.value { self.targetValue = unitConverter.convert(value: targetValue, toUnit: unit, fromUnit: handler.unit) }
        else { self.targetValue = 0.0 }
    }
    
}
