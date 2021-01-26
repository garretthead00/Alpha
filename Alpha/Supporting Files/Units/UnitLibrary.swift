//
//  UnitCount.swift
//  Alpha
//
//  Created by Garrett Head on 1/15/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import Foundation


let UNIT_MAP : [String : Unit] = [
    "g" : UnitMass.grams,
    "kg" : UnitMass.kilograms,
    "mg" : UnitMass.milligrams,
    "µg" : UnitMass.micrograms,
    "lb" : UnitMass.pounds,
    "oz" : UnitMass.ounces,
    "L" : UnitVolume.liters,
    "mL" : UnitVolume.milliliters,
    "fl oz" : UnitVolume.fluidOunces,
    "cup" : UnitVolume.cups,
    "pt" : UnitVolume.pints,
    "qt" : UnitVolume.quarts,
    "gal" : UnitVolume.gallons,
    "hr" : UnitDuration.hours,
    "min" : UnitDuration.minutes,
    "s" : UnitDuration.seconds,
    "mi" : UnitLength.miles,
    "yd" : UnitLength.yards,
    "ft" : UnitLength.feet,
    "in" : UnitLength.inches,
    "m" : UnitLength.meters,
    "cm" : UnitLength.centimeters,
    "km" : UnitLength.kilometers,
    "cal" : UnitEnergy.calories,
    "kCal" : UnitEnergy.kilocalories,
    "mph" : UnitSpeed.milesPerHour,
    "m/s" : UnitSpeed.metersPerSecond,
    "km/h" : UnitSpeed.kilometersPerHour
]


public class UnitCount: Unit {
  static let steps      = UnitCount(symbol: "steps")
  static let workouts   = UnitCount(symbol: "workouts")
  static let jumps      = UnitCount(symbol: "jumps")
  static let laps       = UnitCount(symbol: "laps")
}

public class UnitRatio: Unit {
  static let percent    = UnitCount(symbol: "%")
}
