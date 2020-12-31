//
//  HealthKitSetupAssistant.swift
//  Alpha
//
//  Created by Garrett Head on 12/2/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitSetupAssistant {
    
    private enum HealthkitSetupError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
   
    class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void) {
        
            // Check to see if HealthKit Is Available on this device
            guard HKHealthStore.isHealthDataAvailable() else {
                completion(false, HealthkitSetupError.notAvailableOnDevice)
                return
            }
            
            // Prepare the data types that will interact with HealthKit
            guard let height = HKObjectType.quantityType(forIdentifier: .height),
                let bodyMassIndex = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
                let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass),
                let leanBodyMass = HKObjectType.quantityType(forIdentifier: .leanBodyMass),
                let bodyFatPercentage = HKObjectType.quantityType(forIdentifier: .bodyFatPercentage),
                let waistCircumfrence = HKObjectType.quantityType(forIdentifier: .waistCircumference),
                // Fitness
                let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
                let steps = HKObjectType.quantityType(forIdentifier: .stepCount),
                let stand = HKObjectType.quantityType(forIdentifier: .appleStandTime),
                let exerciseMinutes = HKObjectType.quantityType(forIdentifier: .appleExerciseTime),
                let distance = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning),
                let flightsClimbed = HKObjectType.quantityType(forIdentifier: .flightsClimbed),
                let restingEnergyBurned = HKObjectType.quantityType(forIdentifier: .basalEnergyBurned),
                // Nutrition
                let energyConsumed = HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed),
                let protein = HKObjectType.quantityType(forIdentifier: .dietaryProtein),
                let carbohydrates = HKObjectType.quantityType(forIdentifier: .dietaryCarbohydrates),
                let totalFat = HKObjectType.quantityType(forIdentifier: .dietaryFatTotal),
                let monounsaturatedFat = HKObjectType.quantityType(forIdentifier: .dietaryFatMonounsaturated),
                let polyunsaturatedFat = HKObjectType.quantityType(forIdentifier: .dietaryFatPolyunsaturated),
                let saturatedFat = HKObjectType.quantityType(forIdentifier: .dietaryFatSaturated),
                let cholesterol = HKObjectType.quantityType(forIdentifier: .dietaryCholesterol),
                let fiber = HKObjectType.quantityType(forIdentifier: .dietaryFiber),
                let sugar = HKObjectType.quantityType(forIdentifier: .dietarySugar),
                let vitaminA = HKObjectType.quantityType(forIdentifier: .dietaryVitaminA),
                let thiamin = HKObjectType.quantityType(forIdentifier: .dietaryThiamin),
                let riboflavin = HKObjectType.quantityType(forIdentifier: .dietaryRiboflavin),
                let niacin = HKObjectType.quantityType(forIdentifier: .dietaryNiacin),
                let pantothenicAcid = HKObjectType.quantityType(forIdentifier: .dietaryPantothenicAcid),
                let vitaminB6 = HKObjectType.quantityType(forIdentifier: .dietaryVitaminB6),
                let biotin = HKObjectType.quantityType(forIdentifier: .dietaryBiotin),
                let vitaminB12 = HKObjectType.quantityType(forIdentifier: .dietaryVitaminB12),
                let vitaminC = HKObjectType.quantityType(forIdentifier: .dietaryVitaminC),
                let vitaminD = HKObjectType.quantityType(forIdentifier: .dietaryVitaminD),
                let vitaminE = HKObjectType.quantityType(forIdentifier: .dietaryVitaminE),
                let vitaminK = HKObjectType.quantityType(forIdentifier: .dietaryVitaminK),
                let folate = HKObjectType.quantityType(forIdentifier: .dietaryFolate),
                let calcium = HKObjectType.quantityType(forIdentifier: .dietaryCalcium),
                let chloride = HKObjectType.quantityType(forIdentifier: .dietaryChloride),
                let iron = HKObjectType.quantityType(forIdentifier: .dietaryIron),
                let magnesium = HKObjectType.quantityType(forIdentifier: .dietaryMagnesium),
                let phosphorus = HKObjectType.quantityType(forIdentifier: .dietaryPhosphorus),
                let potassium = HKObjectType.quantityType(forIdentifier: .dietaryPotassium),
                let sodium = HKObjectType.quantityType(forIdentifier: .dietarySodium),
                let zinc = HKObjectType.quantityType(forIdentifier: .dietaryZinc),
                let chromium = HKObjectType.quantityType(forIdentifier: .dietaryChromium),
                let copper = HKObjectType.quantityType(forIdentifier: .dietaryCopper),
                let iodine = HKObjectType.quantityType(forIdentifier: .dietaryIodine),
                let manganese = HKObjectType.quantityType(forIdentifier: .dietaryManganese),
                let molybdenum = HKObjectType.quantityType(forIdentifier: .dietaryMolybdenum),
                let selenium = HKObjectType.quantityType(forIdentifier: .dietarySelenium),
                // Hydration
                let water = HKObjectType.quantityType(forIdentifier: .dietaryWater),
                let caffeine = HKObjectType.quantityType(forIdentifier: .dietaryCaffeine),
                // Sleep
                let sleepMinutes = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis),
                // Mindfulness
                let mindfulMinutes = HKCategoryType.categoryType(forIdentifier: .mindfulSession)else {
                completion(false, HealthkitSetupError.dataTypeNotAvailable)
                return
            }
            
            // Prepare a list of types you want HealthKit to read and write
            let healthKitTypesToWrite: Set<HKSampleType> = [bodyMassIndex,
                                                            height,
                                                            bodyMass,
                                                            leanBodyMass,
                                                            bodyFatPercentage,
                                                            waistCircumfrence,
                                                            activeEnergy,
                                                            steps,
                                                            distance,
                                                            flightsClimbed,
                                                            restingEnergyBurned,
                                                            HKObjectType.workoutType(),
                                                            energyConsumed,
                                                            protein,
                                                            carbohydrates,
                                                            totalFat,
                                                            monounsaturatedFat,
                                                            polyunsaturatedFat,
                                                            saturatedFat,
                                                            cholesterol,
                                                            fiber,
                                                            sugar,
                                                            vitaminA,
                                                            thiamin,
                                                            riboflavin,
                                                            niacin,
                                                            pantothenicAcid,
                                                            vitaminB6,
                                                            biotin,
                                                            vitaminB12,
                                                            vitaminC,
                                                            vitaminD,
                                                            vitaminE,
                                                            vitaminK,
                                                            folate,
                                                            calcium,
                                                            chloride,
                                                            iron,
                                                            magnesium,
                                                            phosphorus,
                                                            potassium,
                                                            sodium,
                                                            zinc,
                                                            chromium,
                                                            copper,
                                                            iodine,
                                                            manganese,
                                                            molybdenum,
                                                            selenium,
                                                            water,
                                                            caffeine]
            
            let healthKitTypesToRead: Set<HKObjectType> = [activeEnergy,
                                                           steps,
                                                           stand,
                                                           exerciseMinutes,
                                                           distance,
                                                           flightsClimbed,
                                                           restingEnergyBurned,
                                                           HKObjectType.workoutType(),
                                                           energyConsumed,
                                                           sleepMinutes,
                                                           mindfulMinutes]
            
            // Request Authorization
            HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) {
                (success, error) in
                completion(success, error)
            }
        }
}
