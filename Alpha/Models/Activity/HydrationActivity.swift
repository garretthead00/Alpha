//
//  HydrationActivity.swift
//  Alpha
//
//  Created by Garrett Head on 11/24/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

struct HydrationActivity : Activity {
    
    // MARK: - Activity Properties
    var name: String
    var icon: UIImage
    var color: UIColor
    var progress: Double?
    var healthKitIdentifiers : [String]?
    var healthKitEnabled : Bool? = false
    var activityType: ActivityType? = .hydration
    
    // MARK: - Hydration Activity Properties
    var water : Double = 0.0
    var totalFluids : Double = 0.0
    var caffeine : Double = 0.0
    var sugar : Double = 0.0
    var sodium : Double = 0.0
    var calcium : Double = 0.0
    var chloride : Double = 0.0
    var magnesium : Double = 0.0
    var phosphorus : Double = 0.0
    var potassium : Double = 0.0
    
    var logs : [NutritionLog] = [] {
        didSet {
            calculateTotals()
        }
    }
    
    init() {
        self.name = "Hydration"
        self.icon = UIImage(named: "Hydration")!
        self.color = .systemBlue
        self.progress = self.water
    }
    
    mutating func calculateTotals(){
        water = logs.reduce(0, {$0 + ($1.water ?? 0.0)})
        caffeine = logs.reduce(0, {$0 + ($1.caffeine ?? 0.0)})
        sugar = logs.reduce(0, {$0 + ($1.sugar ?? 0.0)})
        sodium = logs.reduce(0, {$0 + ($1.sodium ?? 0.0)})
        calcium = logs.reduce(0, {$0 + ($1.calcium ?? 0.0)})
        chloride = logs.reduce(0, {$0 + ($1.chloride ?? 0.0)})
        magnesium = logs.reduce(0, {$0 + ($1.magnesium ?? 0.0)})
        phosphorus = logs.reduce(0, {$0 + ($1.phosphorus ?? 0.0)})
        potassium = logs.reduce(0, {$0 + ($1.potassium ?? 0.0)})
        totalFluids = logs.reduce(0, {$0 + ($1.servingSize ?? 0.0)})
        updateActivity()
    }
    
    mutating func updateActivity(){
        self.progress = self.water
    }
    
    mutating func setValue(forIdentifier id: String, value: Double){
    }
    
    func getValue(ofKey key: String) -> Double {
        var value = 0.0
        switch key {
            case NUTRIENT.Water.rawValue: value = water
            case NUTRIENT.Caffeine.rawValue: value = caffeine
            case NUTRIENT.Sodium.rawValue: value = sodium
            case NUTRIENT.Sugar.rawValue: value = sugar
            case NUTRIENT.Calcium.rawValue: value = calcium
            case NUTRIENT.Chloride.rawValue: value = chloride
            case NUTRIENT.Magnesium.rawValue: value = magnesium
            case NUTRIENT.Phosphorus.rawValue: value = phosphorus
            case NUTRIENT.Potassium.rawValue: value = potassium
            case NUTRIENT.TotalFluids.rawValue: value = totalFluids
            default: value = 0.0
        }
        return value
    }
}
