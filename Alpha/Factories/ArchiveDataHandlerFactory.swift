//
//  ArchiveDataHandlerFactory.swift
//  Alpha
//
//  Created by Garrett Head on 1/17/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

struct ArchiveDataHandlerFactory {
    
    func makeDataHandler(_ identifier: ACTIVITY_DATA_IDENTIFIER, data: [Date : Double]) -> ActivityDataHandler {
        switch identifier {
            case .EnergyBurned:         return ActivityDataHandler(id: .EnergyBurned, name: "Energy Burned", description :"", icon: UIImage(named:"EnergyBurned")!, data: data, unit: UnitEnergy.calories)
            case .Steps:                return ActivityDataHandler(id: .Steps, name: "Steps", description :"", icon: UIImage(named:"Steps")!, data: data, unit: UnitCount.steps)
            case .Distance:             return ActivityDataHandler(id: .Distance, name: "Distance", description :"", icon: UIImage(named:"Distance")!, data: data, unit: UnitLength.meters)
            case .WorkoutsCompleted:    return ActivityDataHandler(id: .WorkoutsCompleted, name: "Workouts", description :"", icon: UIImage(named:"WorkoutsCompleted")!, data: data, unit: UnitCount.workouts)
            case .ExerciseMinutes:      return ActivityDataHandler(id: .ExerciseMinutes, name: "Exercise Minutes", description :"", icon: UIImage(named:"ExerciseMinutes")!, data: data, unit: UnitDuration.minutes)
            case .EnergyConsumed:       return ActivityDataHandler(id: .EnergyConsumed, name: "Energy Consumed", description :"", icon: UIImage(named:"EnergyConsumed")!, data: data, unit: UnitEnergy.calories)
            case .Protein:              return ActivityDataHandler(id: .Protein, name: "Protein", description :"", icon: UIImage(named:"Protein")!, data: data, unit: UnitMass.grams)
            case .Carbohydrates:        return ActivityDataHandler(id: .Carbohydrates, name: "Carbohydrates", description :"", icon: UIImage(named:"Carbohydrates")!, data: data, unit: UnitMass.grams)
            case .Fat:                  return ActivityDataHandler(id: .Fat, name: "Fat", description :"", icon: UIImage(named:"Fat")!, data: data, unit: UnitMass.grams)
            case .Sugar:                return ActivityDataHandler(id: .Sugar, name: "Sugar", description :"", icon: UIImage(named:"Sugar")!, data: data, unit: UnitMass.grams)
            case .Fiber:                return ActivityDataHandler(id: .Fiber, name: "Fiber", description :"", icon: UIImage(named:"Fiber")!, data: data, unit: UnitMass.grams)
            case .Cholesterol:          return ActivityDataHandler(id: .Cholesterol, name: "Cholesterol", description :"", icon: UIImage(named:"Cholesterol")!, data: data, unit: UnitMass.grams)
            case .MonounsaturatedFat:   return ActivityDataHandler(id: .MonounsaturatedFat, name: "Monounsaturated Fat", description :"", icon: UIImage(named:"MonounsaturatedFat")!, data: data, unit: UnitMass.grams)
            case .PolyunsaturatedFat:   return ActivityDataHandler(id: .PolyunsaturatedFat, name: "Polyunsaturated Fat", description :"", icon: UIImage(named:"PolyunsaturatedFat")!, data: data, unit: UnitMass.grams)
            case .SaturatedFat:         return ActivityDataHandler(id: .SaturatedFat, name: "Saturated Fat", description :"", icon: UIImage(named:"SaturatedFat")!, data: data, unit: UnitMass.grams)
            case .TotalFluids:          return ActivityDataHandler(id: .TotalFluids, name: "Total Fluids", description :"", icon: UIImage(named:"TotalFluids")!, data: data, unit: UnitVolume.liters)
            case .Caffeine:             return ActivityDataHandler(id: .Caffeine, name: "Caffeine", description :"", icon: UIImage(named:"Caffeine")!, data: data, unit: UnitMass.grams)
            case .VitaminA:             return ActivityDataHandler(id: .VitaminA, name: "Vitamin A", description :"", icon: UIImage(named:"VitaminA")!, data: data, unit: UnitMass.grams)
            case .VitaminB1:            return ActivityDataHandler(id: .VitaminB1, name: "Vitamin B1", description :"", icon: UIImage(named:"VitaminB1")!, data: data, unit: UnitMass.grams)
            case .VitaminB12:           return ActivityDataHandler(id: .VitaminB12, name: "Vitamin B12", description :"", icon: UIImage(named:"VitaminB12")!, data: data, unit: UnitMass.grams)
            case .VitaminB2:            return ActivityDataHandler(id: .VitaminB2, name: "Vitamin B2", description :"", icon: UIImage(named:"VitaminB2")!, data: data, unit: UnitMass.grams)
            case .VitaminB3:            return ActivityDataHandler(id: .VitaminB3, name: "Vitamin B3", description :"", icon: UIImage(named:"VitaminB3")!, data: data, unit: UnitMass.grams)
            case .VitaminB5:            return ActivityDataHandler(id: .VitaminB5, name: "Vitamin B5", description :"", icon: UIImage(named:"VitaminB5")!, data: data, unit: UnitMass.grams)
            case .VitaminB6:            return ActivityDataHandler(id: .VitaminB6, name: "Vitamin B6", description :"", icon: UIImage(named:"VitaminB6")!, data: data, unit: UnitMass.grams)
            case .VitaminB7:            return ActivityDataHandler(id: .VitaminB7, name: "Vitamin B7", description :"", icon: UIImage(named:"VitaminB7")!, data: data, unit: UnitMass.grams)
            case .VitaminC:             return ActivityDataHandler(id: .VitaminC, name: "Vitamin C", description :"", icon: UIImage(named:"VitaminC")!, data: data, unit: UnitMass.grams)
            case .VitaminD:             return ActivityDataHandler(id: .VitaminD, name: "Vitamin D", description :"", icon: UIImage(named:"VitaminD")!, data: data, unit: UnitMass.grams)
            case .VitaminE:             return ActivityDataHandler(id: .VitaminE, name: "Vitamin E", description :"", icon: UIImage(named:"VitaminE")!, data: data, unit: UnitMass.grams)
            case .VitaminK:             return ActivityDataHandler(id: .VitaminK, name: "Vitamin K", description :"", icon: UIImage(named:"VitaminK")!, data: data, unit: UnitMass.grams)
            case .Folate:               return ActivityDataHandler(id: .Folate, name: "Folate", description :"", icon: UIImage(named:"Folate")!, data: data, unit: UnitMass.grams)
            case .Calcium:              return ActivityDataHandler(id: .Calcium, name: "Calcium", description :"", icon: UIImage(named:"Calcium")!, data: data, unit: UnitMass.grams)
            case .Chloride:             return ActivityDataHandler(id: .Chloride, name: "Chloride", description :"", icon: UIImage(named:"Chloride")!, data: data, unit: UnitMass.grams)
            case .Iron:                 return ActivityDataHandler(id: .Iron, name: "Iron", description :"", icon: UIImage(named:"Iron")!, data: data, unit: UnitMass.grams)
            case .Magnesium:            return ActivityDataHandler(id: .Magnesium, name: "Magnesium", description :"", icon: UIImage(named:"Magnesium")!, data: data, unit: UnitMass.grams)
            case .Phosphorus:           return ActivityDataHandler(id: .Phosphorus, name: "Phosphorus", description :"", icon: UIImage(named:"Phosphorus")!, data: data, unit: UnitMass.grams)
            case .Potassium:            return ActivityDataHandler(id: .Potassium, name: "Potassium", description :"", icon: UIImage(named:"Potassium")!, data: data, unit: UnitMass.grams)
            case .Sodium:               return ActivityDataHandler(id: .Sodium, name: "Sodium", description :"", icon: UIImage(named:"Sodium")!, data: data, unit: UnitMass.grams)
            case .Zinc:                 return ActivityDataHandler(id: .Zinc, name: "Zinc", description :"", icon: UIImage(named:"Zinc")!, data: data, unit: UnitMass.grams)
            case .Chromium:             return ActivityDataHandler(id: .Chromium, name: "Chromium", description :"", icon: UIImage(named:"Chromium")!, data: data, unit: UnitMass.grams)
            case .Copper:               return ActivityDataHandler(id: .Copper, name: "Copper", description :"", icon: UIImage(named:"Copper")!, data: data, unit: UnitMass.grams)
            case .Iodine:               return ActivityDataHandler(id: .Iodine, name: "Iodine", description :"", icon: UIImage(named:"Iodine")!, data: data, unit: UnitMass.grams)
            case .Manganese:            return ActivityDataHandler(id: .Manganese, name: "Manganese", description :"", icon: UIImage(named:"Manganese")!, data: data, unit: UnitMass.grams)
            case .Molybdenum:           return ActivityDataHandler(id: .Molybdenum, name: "Molybdenum", description :"", icon: UIImage(named:"Molybdenum")!, data: data, unit: UnitMass.grams)
            case .Selenium:             return ActivityDataHandler(id: .Selenium, name: "Selenium", description :"", icon: UIImage(named:"Selenium")!, data: data, unit: UnitMass.grams)
            case .Water:                return ActivityDataHandler(id: .Water, name: "Water", description :"", icon: UIImage(named:"Water")!, data: data, unit: UnitVolume.liters)
            case .SleepMinutes:         return ActivityDataHandler(id: .SleepMinutes, name: "Sleep Minutes", description :"", icon: UIImage(named:"SleepMinutes")!, data: data, unit: UnitDuration.minutes)
            case .MindfulMinutes:       return ActivityDataHandler(id: .MindfulMinutes, name: "Mindful Minutes", description :"", icon: UIImage(named:"MindfulMinutes")!, data: data, unit: UnitDuration.minutes)
        }
        
    }
    
    

    
}
