//
//  ArchiveDataHandler.swift
//  Alpha
//
//  Created by Garrett Head on 1/2/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

struct ActivityDataHandler {
    
    var id : ACTIVITY_DATA_IDENTIFIER
    var name : String
    var description : String
    var unit : Unit
    var icon : UIImage
    var data : [Date:Double]
    var preferredUnit : Unit? // API set
    
    var total : Double {
        let value = data.reduce(0, {$0 + ($1.1)})
        return data.count > 0 ? value : 0.0
        
    }
    var average : Double { return data.count > 0 ? data.reduce(0, {$0 + ($1.1)}) / Double(data.count) : 0.0 }
    var count : Int { return data.count > 0 ? data.count : 0 }
    var currentValue : Double {
        let key = data.keys.sorted(by: { $0 < $1 }).first
        return data[key!] ?? 0.0
    }
    
    var target : UserTarget?
    var progress : Double? { return target != nil ? total / target!.value! * 100 : 0.0 }
    var remaining : Double? { return target != nil ? target!.value! - total : 0.0 }

    
    init(id: ACTIVITY_DATA_IDENTIFIER, name: String, description : String, icon : UIImage, data: [Date:Double], unit: Unit) {
        self.id = id
        self.name = name
        self.description = description
        self.data = data
        self.icon = icon
        self.description = description
        self.unit = unit
    }
    
    init(id: ACTIVITY_DATA_IDENTIFIER, name: String, description : String, icon : UIImage, data: [Date:Double], unit: Unit, target: UserTarget) {
        self.id = id
        self.name = name
        self.description = description
        self.data = data
        self.icon = icon
        self.description = description
        self.unit = unit
        self.target = target
    }
    
    private func convert(value: Double, toUnit to: Unit, fromUnit from: Unit) -> Double {
        
        if let toUnit = to as? Dimension, let fromUnit = from as? Dimension {
            print("convert to: \(to.symbol) from: \(from.symbol)")
            let baseMeasurement = Measurement(value: value, unit: fromUnit)
            let convertedMeasurement = baseMeasurement.converted(to: toUnit)
            print("convert value to: \(convertedMeasurement.value) \(convertedMeasurement.unit.symbol) from: \(value) \(fromUnit.symbol)")
            return convertedMeasurement.value
        }
        return value
    }
}
