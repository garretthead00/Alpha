//
//  NutritionActivity.swift
//  Alpha
//
//  Created by Garrett Head on 11/24/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import UIKit


struct NutritionActivity : Activity {
    
    // MARK: - Activity properties
    var name: String
    var icon: UIImage
    var color: UIColor
    var progress: Double?
    var healthKitIdentifiers : [String]?
    var healthKitEnabled : Bool? = false
    var activityType: ActivityType? = .nutrition

    
    // MARK: - Nutrition Activity Properties
    var energyConsumed : Double = 0.0

    // Macros
    var protein : Double = 0.0
    var carbohydrates : Double = 0.0
    var fat : Double = 0.0

    // Carbohydrates
    var sugar : Double = 0.0
    var fiber : Double = 0.0

    // Lipids
    var cholesterol : Double = 0.0
    var monounsaturatedFat : Double = 0.0
    var polyunsaturatedFat : Double = 0.0
    var saturatedFat : Double = 0.0

    // Other
    var totalFluids : Double = 0.0
    var water : Double = 0.0
    var caffeine : Double = 0.0

    // Vitamins
    var vitaminA : Double = 0.0
    var vitaminB1 : Double = 0.0
    var vitaminB12 : Double = 0.0
    var vitaminB2 : Double = 0.0
    var vitaminB3 : Double = 0.0
    var vitaminB5 : Double = 0.0
    var vitaminB6 : Double = 0.0
    var vitaminB7 : Double = 0.0
    var vitaminC : Double = 0.0
    var vitaminD : Double = 0.0
    var vitaminE : Double = 0.0
    var vitaminK : Double = 0.0
    var folate : Double = 0.0

    // Minerals
    var calcium : Double = 0.0
    var chloride : Double = 0.0
    var iron : Double = 0.0
    var magnesium : Double = 0.0
    var phosphorus : Double = 0.0
    var potassium : Double = 0.0
    var sodium : Double = 0.0
    var zinc : Double = 0.0

    // Ultra-Trace Minerals
    var chromium : Double = 0.0
    var copper : Double = 0.0
    var iodine : Double = 0.0
    var manganese : Double = 0.0
    var molybdenum : Double = 0.0
    var selenium : Double = 0.0
    
    var logs : [NutritionLog] = [] {
        didSet {
            calculateTotals()
        }
    }

    init() {
        self.name = "Nutrition"
        self.icon = UIImage(named: "Nutrition")!
        self.color = .systemGreen
        self.progress = self.energyConsumed
    }
    
    mutating func calculateTotals(){
        energyConsumed = logs.reduce(0, {$0 + ($1.energyConsumed ?? 0.0)})
        protein = logs.reduce(0, {$0 + ($1.protein ?? 0.0)})
        fat = logs.reduce(0, {$0 + ($1.fat ?? 0.0)})
        carbohydrates = logs.reduce(0, {$0 + ($1.carbohydrates ?? 0.0)})
        // Carbohydrates
        sugar = logs.reduce(0, {$0 + ($1.sugar ?? 0.0)})
        fiber = logs.reduce(0, {$0 + ($1.fiber ?? 0.0)})

        // Lipids
        cholesterol = logs.reduce(0, {$0 + ($1.cholesterol ?? 0.0)})
        monounsaturatedFat = logs.reduce(0, {$0 + ($1.monounsaturatedFat ?? 0.0)})
        polyunsaturatedFat = logs.reduce(0, {$0 + ($1.polyunsaturatedFat ?? 0.0)})
        saturatedFat = logs.reduce(0, {$0 + ($1.saturatedFat ?? 0.0)})

        // Other
        water = logs.reduce(0, {$0 + ($1.water ?? 0.0)})
        caffeine = logs.reduce(0, {$0 + ($1.caffeine ?? 0.0)})

        // Vitamins
        vitaminA = logs.reduce(0, {$0 + ($1.vitaminA ?? 0.0)})
        vitaminB1 = logs.reduce(0, {$0 + ($1.vitaminB1 ?? 0.0)})
        vitaminB12 = logs.reduce(0, {$0 + ($1.vitaminB12 ?? 0.0)})
        vitaminB2 = logs.reduce(0, {$0 + ($1.vitaminB2 ?? 0.0)})
        vitaminB3 = logs.reduce(0, {$0 + ($1.vitaminB3 ?? 0.0)})
        vitaminB5 = logs.reduce(0, {$0 + ($1.vitaminB5 ?? 0.0)})
        vitaminB6 = logs.reduce(0, {$0 + ($1.vitaminB6 ?? 0.0)})
        vitaminB7 = logs.reduce(0, {$0 + ($1.vitaminB7 ?? 0.0)})
        vitaminC = logs.reduce(0, {$0 + ($1.vitaminC ?? 0.0)})
        vitaminD = logs.reduce(0, {$0 + ($1.vitaminD ?? 0.0)})
        vitaminE = logs.reduce(0, {$0 + ($1.vitaminE ?? 0.0)})
        vitaminK = logs.reduce(0, {$0 + ($1.vitaminK ?? 0.0)})
        folate = logs.reduce(0, {$0 + ($1.folate ?? 0.0)})

        // Minerals
        calcium = logs.reduce(0, {$0 + ($1.calcium ?? 0.0)})
        chloride = logs.reduce(0, {$0 + ($1.chloride ?? 0.0)})
        iron = logs.reduce(0, {$0 + ($1.iron ?? 0.0)})
        magnesium = logs.reduce(0, {$0 + ($1.magnesium ?? 0.0)})
        phosphorus = logs.reduce(0, {$0 + ($1.phosphorus ?? 0.0)})
        potassium = logs.reduce(0, {$0 + ($1.potassium ?? 0.0)})
        sodium = logs.reduce(0, {$0 + ($1.sodium ?? 0.0)})
        zinc = logs.reduce(0, {$0 + ($1.zinc ?? 0.0)})

        // Ultra-Trace Minerals
        chromium = logs.reduce(0, {$0 + ($1.chromium ?? 0.0)})
        copper = logs.reduce(0, {$0 + ($1.copper ?? 0.0)})
        iodine = logs.reduce(0, {$0 + ($1.iodine ?? 0.0)})
        manganese = logs.reduce(0, {$0 + ($1.manganese ?? 0.0)})
        molybdenum = logs.reduce(0, {$0 + ($1.molybdenum ?? 0.0)})
        selenium = logs.reduce(0, {$0 + ($1.selenium ?? 0.0)})
        updateActivity()
    }
    
    mutating func updateActivity(){
        self.progress = self.energyConsumed
    }
    
    func setValue(forIdentifier id: String, value: Double){
    }
    
    func getValue(ofKey key: String) -> Double {
        var value = 0.0
        switch key {
            case "energyConsumed": value = energyConsumed
            case "protein": value = protein
            case "fats": value = fat
            case "carbohydrates": value = carbohydrates
            default: value = 0.0
        }
        return value
    }
}




