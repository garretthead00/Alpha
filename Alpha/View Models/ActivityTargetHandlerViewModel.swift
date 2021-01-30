//
//  ActivityTargetHandlerViewModel.swift
//  Alpha
//
//  Created by Garrett Head on 1/25/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

struct ActivityTargetHandlerViewModel{

    let identifier : ACTIVITY_DATA_IDENTIFIER
    let name : String
    let icon : UIImage
    let unit : Unit
    var value : Double
     let targetType : ActivityType
    
    init(handler: ActivityDataHandler, unit: Unit){
        self.identifier = handler.id
        self.name = handler.name
        self.icon = handler.icon
        self.unit = unit
        if let targetValue = handler.target!.value {
            let unitConverter = UnitConverter()
            let convertedValue = unitConverter.convert(value: targetValue, toUnit: unit, fromUnit: handler.unit)
            self.value = convertedValue
        } else {
            print("no conversion of value. \(handler.name)")
            self.value = 0.0
        }
        if let type = handler.target!.targetType {
            self.targetType = type
        } else {
            self.targetType = .fitness
        }
    }
    
}
