//
//  TargetedHandlerStackViewModel.swift
//  Alpha
//
//  Created by Garrett Head on 2/6/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

class TargetedHandlerStackViewModel {
    
    var name : String
    var icon : UIImage
    var value : Double
    var targetValue : Double
    var unit : String

    init(handler: ActivityDataHandler, ofUnit unit: Unit, target: UserTarget){
        self.name = String(handler.name.split(separator: " ").first!)
        self.icon = handler.icon
        self.unit = unit.symbol
        let unitConverter = UnitConverter()
        self.value = unitConverter.convert(value: handler.total, toUnit: unit, fromUnit: handler.unit)
        self.targetValue = unitConverter.convert(value: target.value!, toUnit: unit, fromUnit: handler.unit)
    }
    
}
