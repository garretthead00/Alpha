//
//  PreferredUnitFactory.swift
//  Alpha
//
//  Created by Garrett Head on 1/17/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import Foundation

struct PreferredUnitFactory {
    func createUnit(_ identifier: ACTIVITY_DATA_IDENTIFIER, units: PreferredUnits) -> Unit {
        let unit : Unit
        switch identifier {
        
        // Energy
            case .EnergyBurned, .EnergyConsumed:
                if units.energy == UnitEnergy.calories.symbol { unit = UnitEnergy.calories }
                else { unit = UnitEnergy.kilocalories }
                
        // Volume
            case .Water, .TotalFluids:
                if units.volume == UnitVolume.liters.symbol { unit = UnitVolume.liters }
                else if units.volume == UnitVolume.milliliters.symbol { unit = UnitVolume.milliliters }
                else if units.volume == UnitVolume.cups.symbol { unit = UnitVolume.cups }
                else { unit = UnitVolume.fluidOunces }
        // Mass
            case .Sugar, .Fiber, .Cholesterol, .MonounsaturatedFat, .PolyunsaturatedFat, .SaturatedFat, .Caffeine, .VitaminA, .VitaminB1, .VitaminB12, .VitaminB2, .VitaminB3, .VitaminB5, .VitaminB6, .VitaminB7, .VitaminC, .VitaminD, .VitaminE, .VitaminK, .Folate, .Calcium, .Chloride, .Iron, .Magnesium, .Phosphorus, .Potassium, .Sodium, .Zinc, .Chromium, .Copper, .Iodine, .Manganese, .Molybdenum, .Selenium:
                if units.nutrition == UnitMass.grams.symbol { unit = UnitMass.grams }
                else if units.nutrition == UnitMass.milligrams.symbol { unit = UnitMass.milligrams }
                else { unit = UnitMass.micrograms }
                
            case .Protein, .Carbohydrates, .Fat:
                if units.macros == UnitMass.grams.symbol { unit = UnitMass.grams }
                else { unit = UnitMass.ounces }
        
        // Duration
            case .SleepMinutes, .MindfulMinutes, .ExerciseMinutes:
                if units.time == UnitDuration.minutes.symbol { unit = UnitDuration.minutes }
                else { unit = UnitDuration.hours }
                
        // Length
            case .Distance:
                if units.distance == UnitLength.meters.symbol { unit = UnitLength.meters }
                else if units.distance == UnitLength.kilometers.symbol { unit = UnitLength.kilometers }
                else if units.distance == UnitLength.feet.symbol { unit = UnitLength.feet }
                else if units.distance == UnitLength.yards.symbol { unit = UnitLength.yards }
                else { unit = UnitLength.miles }
        // Count
            case .Steps : unit = UnitCount.steps
            case .WorkoutsCompleted : unit = UnitCount.workouts
        }
        return unit
    }
}




