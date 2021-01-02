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
        water = logs.reduce(0, {$0 + ($1.servingSize ?? 0.0)})
        updateActivity()
    }
    
    mutating func updateActivity(){
        self.progress = self.water
    }
    
    func setValue(forIdentifier id: String, value: Double){
    }
    
    func getValue(ofKey key: String) -> Double {
        var value = 0.0
        switch key {
            case NUTRIENT.Water.rawValue: value = water
            default: value = 0.0
        }
        return value
    }
}
