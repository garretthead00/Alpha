//
//  UnitConverter.swift
//  
//
//  Created by Garrett Head on 1/25/21.
//

import Foundation

struct UnitConverter {
    func convert(value: Double, toUnit to: Unit, fromUnit from: Unit) -> Double {
        if let toDimension = to as? Dimension,
        let fromDimension = from as? Dimension {
            let baseMeasurement = Measurement(value: value, unit: fromDimension)
            let convertedMeasurement = baseMeasurement.converted(to: toDimension)
            return convertedMeasurement.value
        }
        return value
    }
}
