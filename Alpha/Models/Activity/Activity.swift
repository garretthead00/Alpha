//
//  Activity.swift
//  Alpha
//
//  Created by Garrett Head on 11/20/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

enum ActivityType {
    case fitness
    case nutrition
    case hydration
    case sleep
    case mindfulness
}

protocol Activity {
    var name : String { get }
    var icon : UIImage { get }
    var color : UIColor { get }
    var progress : Double? { get set }
    var healthKitIdentifiers : [String]? { get set }
    var healthKitEnabled : Bool? { get set }
    var activityType : ActivityType? { get set }
    mutating func setValue(forIdentifier id: String, value: Double)
    mutating func updateActivity()
    mutating func calculateTotals()
    func getValue(ofKey key: String) -> Double
}


enum ACTIVITY_IDENTIFIERS : String {
    
    // FITNESS
    case EnergyBurned = "EnergyBurned"
    case Steps = "Steps"
    case Distance = "Distance"
    case WorkoutsCompleted = "WorkoutsCompleted"
    case ExerciseMinutes = "ExerciseMinutes"

    // Energy
    case EnergyConsumed = "EnergyConsumed"

    // Macros
    case Protein = "Protein"
    case Carbs = "Carbohydrates"
    case Fat = "Fat"
    
    // Carbohydrates
    case Sugar = "Sugar"
    case Fiber = "Fiber"
    
    // Lipids
    case Cholesterol = "Cholesterol"
    case MonounsaturatedFat = "MonounsaturatedFat"
    case PolyunsaturatedFat = "PolyunsaturatedFat"
    case SaturatedFat = "SaturatedFat"
    
    // Other
    case TotalFluids = "TotalFluids"
    case Water = "Water"
    case Caffeine = "Caffeine"
    
    // Vitamins
    case VitaminA = "VitaminA"
    case VitaminB1 = "VitaminB1"
    case VitaminB12 = "VitaminB12"
    case VitaminB2 = "VitaminB2"
    case VitaminB3 = "VitaminB3"
    case VitaminB5 = "VitaminB5"
    case VitaminB6 = "VitaminB6"
    case VitaminB7 = "VitaminB7"
    case VitaminC = "VitaminC"
    case VitaminD = "VitaminD"
    case VitaminE = "VitaminE"
    case VitaminK = "VitaminK"
    case Folate = "Folate"
    
    // Minerals
    case Calcium = "Calcium"
    case Chloride = "Chloride"
    case Iron = "Iron"
    case Magnesium = "Magnesium"
    case Phosphorus = "Phosphorus"
    case Potassium = "Potassium"
    case Sodium = "Sodium"
    case Zinc = "Zinc"
    
    // Ultra-Trace Minerals
    case Chromium = "Chromium"
    case Copper = "Copper"
    case Iodine = "Iodine"
    case Manganese = "Manganese"
    case Molybdenum = "Molybdenum"
    case Selenium = "Selenium"
}