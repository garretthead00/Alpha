//
//  NutritionLog.swift
//  Alpha
//
//  Created by Garrett Head on 11/24/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

struct NutritionLog : ActivityLog {
    var id : String?
    var uid : String?
    var sessionId : String?
    var timestamp : Date?
    
    
    // MARK: - Food Properties
    var foodId : String?
    var food : Food?
    var servingSize : Double?
    var servingUnit : String?
    
    // MARK: - Nutrition Activity Properties
    var energyConsumed : Double?

    // Macros
    var protein : Double?
    var carbohydrates : Double?
    var fat : Double?

    // Carbohydrates
    var sugar : Double?
    var fiber : Double?

    // Lipids
    var cholesterol : Double?
    var monounsaturatedFat : Double?
    var polyunsaturatedFat : Double?
    var saturatedFat : Double?

    // Other
    var fluids : Double?
    var water : Double?
    var caffeine : Double?

    // Vitamins
    var vitaminA : Double?
    var vitaminB1 : Double?
    var vitaminB12 : Double?
    var vitaminB2 : Double?
    var vitaminB3 : Double?
    var vitaminB5 : Double?
    var vitaminB6 : Double?
    var vitaminB7 : Double?
    var vitaminC : Double?
    var vitaminD : Double?
    var vitaminE : Double?
    var vitaminK : Double?
    var folate : Double?

    // Minerals
    var calcium : Double?
    var chloride : Double?
    var iron : Double?
    var magnesium : Double?
    var phosphorus : Double?
    var potassium : Double?
    var sodium : Double?
    var zinc : Double?

    // Ultra-Trace Minerals
    var chromium : Double?
    var copper : Double?
    var iodine : Double?
    var manganese : Double?
    var molybdenum : Double?
    var selenium : Double?
    
    init(){}
    
    init(id: String, uid: String, foodId: String, timestamp: Double, servingSize: Double, servingUnit: String, energyConsumed: Double, protein: Double, fats: Double, carbs: Double){
        self.id = id
        self.uid = uid
        self.timestamp = Date(timeIntervalSince1970: timestamp)
        self.foodId = foodId
        self.servingSize = servingSize
        self.servingUnit = servingUnit
        self.energyConsumed = energyConsumed
        self.protein = protein
        self.fat = fats
        self.carbohydrates = carbs


    }
}

extension NutritionLog {
    static func transformLog(data: [String: Any], key: String) -> NutritionLog? {
        var log = NutritionLog()
        log.id = key
        log.foodId = data["foodId"] as? String
        log.timestamp = Date(timeIntervalSince1970: data["timestamp"] as! Double)
        
        log.energyConsumed = data["energy"] as? Double
        log.protein = data["protein"] as? Double
        log.fat = data["fat"] as? Double
        log.carbohydrates = data["carbohydrates"] as? Double
        
        // Carbohydrates
         log.sugar = data["sugar"] as? Double
         log.fiber = data["fiber"] as? Double

        // Lipids
         log.cholesterol = data["cholesterol"] as? Double
         log.monounsaturatedFat = data["monounsaturatedFat"] as? Double
         log.polyunsaturatedFat = data["polyunsaturatedFat"] as? Double
         log.saturatedFat = data["saturatedFat"] as? Double

        // Other
         //log.fluids = data["fluids"] as? Double
         log.water = data["water"] as? Double
         log.caffeine = data["caffeine"] as? Double

        // Vitamins
         log.vitaminA = data["vitaminA"] as? Double
         log.vitaminB1 = data["vitaminB1"] as? Double
         log.vitaminB12 = data["vitaminB12"] as? Double
         log.vitaminB2 = data["vitaminB2"] as? Double
         log.vitaminB3 = data["vitaminB3"] as? Double
         log.vitaminB5 = data["vitaminB5"] as? Double
         log.vitaminB6 = data["vitaminB6"] as? Double
         log.vitaminB7 = data["vitaminB7"] as? Double
         log.vitaminC = data["vitaminC"] as? Double
         log.vitaminD = data["vitaminD"] as? Double
         log.vitaminE = data["vitaminE"] as? Double
         log.vitaminK = data["vitaminK"] as? Double
         log.folate = data["folate"] as? Double

        // Minerals
         log.calcium = data["calcium"] as? Double
         log.chloride = data["chloride"] as? Double
         log.iron = data["iron"] as? Double
         log.magnesium = data["magnesium"] as? Double
         log.phosphorus = data["phosphorus"] as? Double
         log.potassium = data["potassium"] as? Double
         log.sodium = data["sodium"] as? Double
         log.zinc = data["zinc"] as? Double

        // Ultra-Trace Minerals
         log.chromium = data["chromium"] as? Double
         log.copper = data["copper"] as? Double
         log.iodine = data["iodine"] as? Double
         log.manganese = data["manganese"] as? Double
         log.molybdenum = data["molybdenum"] as? Double
         log.selenium = data["selenium"] as? Double
         return log
    }
    
    static func transformLog(data: [String: Any], food: Food, key: String) -> NutritionLog? {
        var log = NutritionLog()
        log.id = key
        log.foodId = data["foodId"] as? String
        log.timestamp = Date(timeIntervalSince1970: data["timestamp"] as! Double)
        
        log.food = food
        log.servingSize = data["servingSize"] as? Double
        log.servingUnit = data["servingUnit"] as? String
        
        // NUTRITION
        log.energyConsumed = data["energy"] as? Double
        log.protein = data["protein"] as? Double
        log.fat = data["fat"] as? Double
        log.carbohydrates = data["carbohydrates"] as? Double
        
        // Carbohydrates
         log.sugar = data["sugar"] as? Double
         log.fiber = data["fiber"] as? Double

        // Lipids
         log.cholesterol = data["cholesterol"] as? Double
         log.monounsaturatedFat = data["monounsaturatedFat"] as? Double
         log.polyunsaturatedFat = data["polyunsaturatedFat"] as? Double
         log.saturatedFat = data["saturatedFat"] as? Double

        // Other
         //log.fluids = data["fluids"] as? Double
        log.water = data[ACTIVITY_IDENTIFIERS.Water.rawValue] as? Double
        log.caffeine = data["caffeine"] as? Double

        // Vitamins
         log.vitaminA = data["vitaminA"] as? Double
         log.vitaminB1 = data["vitaminB1"] as? Double
         log.vitaminB12 = data["vitaminB12"] as? Double
         log.vitaminB2 = data["vitaminB2"] as? Double
         log.vitaminB3 = data["vitaminB3"] as? Double
         log.vitaminB5 = data["vitaminB5"] as? Double
         log.vitaminB6 = data["vitaminB6"] as? Double
         log.vitaminB7 = data["vitaminB7"] as? Double
         log.vitaminC = data["vitaminC"] as? Double
         log.vitaminD = data["vitaminD"] as? Double
         log.vitaminE = data["vitaminE"] as? Double
         log.vitaminK = data["vitaminK"] as? Double
         log.folate = data["folate"] as? Double

        // Minerals
         log.calcium = data["calcium"] as? Double
         log.chloride = data["chloride"] as? Double
         log.iron = data["iron"] as? Double
         log.magnesium = data["magnesium"] as? Double
         log.phosphorus = data["phosphorus"] as? Double
         log.potassium = data["potassium"] as? Double
         log.sodium = data["sodium"] as? Double
         log.zinc = data["zinc"] as? Double

        // Ultra-Trace Minerals
         log.chromium = data["chromium"] as? Double
         log.copper = data["copper"] as? Double
         log.iodine = data["iodine"] as? Double
         log.manganese = data["manganese"] as? Double
         log.molybdenum = data["molybdenum"] as? Double
         log.selenium = data["selenium"] as? Double
         return log
    }
}
