//
//  Nutrition.swift
//  Alpha
//
//  Created by Garrett Head on 12/23/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

enum NUTRIENT : String {
    // Energy
    case Energy = "Calories"

    // Macros
    case Protein = "Protein"
    case Carbs = "Carbohydrates"
    case Fat = "Fat"
    
    // Carbohydrates
    case Sugar = "Sugar"
    case Fiber = "Fiber"
    
    // Lipids
    case Cholesterol = "Cholesterol"
    case MonounsaturatedFat = "Monounsaturated Fat"
    case PolyunsaturatedFat = "Polyunsaturated Fat"
    case SaturatedFat = "Saturated Fat"
    
    // Other
    case TotalFluids = "Total Fluids"
    case Water = "Water"
    case Caffeine = "Caffeine"
    
    // Vitamins
    case VitaminA = "Vitamin A"
    case VitaminB1 = "Vitamin B1"
    case VitaminB12 = "Vitamin B12"
    case VitaminB2 = "Vitamin B2"
    case VitaminB3 = "Vitamin B3"
    case VitaminB5 = "Vitamin B5"
    case VitaminB6 = "Vitamin B6"
    case VitaminB7 = "Vitamin B7"
    case VitaminC = "Vitamin C"
    case VitaminD = "Vitamin D"
    case VitaminE = "Vitamin E"
    case VitaminK = "Vitamin K"
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
