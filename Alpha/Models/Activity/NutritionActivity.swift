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
    var progress: Double? {
        let handler = archiveDataHandlers.filter({ $0.id == progressIdentifier }).first
        return handler?.total
    }
    var healthKitIdentifiers : [String]?
    var healthKitEnabled : Bool? = false
    var activityType: ActivityType? = .nutrition
    var logs : [NutritionLog] = []
    
    var progressIdentifier : ACTIVITY_DATA_IDENTIFIER = .EnergyConsumed
    var activityDataIdentifiers : [ACTIVITY_DATA_IDENTIFIER] = [.EnergyConsumed, .Protein, .Carbohydrates, .Fat, .Sugar, .Fiber, .Cholesterol, .MonounsaturatedFat, .PolyunsaturatedFat, .SaturatedFat, .TotalFluids, .Caffeine, .VitaminA, .VitaminB1, .VitaminB2, .VitaminB3, .VitaminB5, .VitaminB6, .VitaminB7, .VitaminC, .VitaminD, .VitaminE, .VitaminK, .Folate, .Calcium, .Chloride, .Iron, .Magnesium, .Manganese, .Phosphorus, .Potassium, .Sodium, .Zinc, .Chromium, .Copper, .Iodine, .Molybdenum, .Selenium]
    var archiveDataHandlers : [ActivityDataHandler] = []
    
    init() {
        self.name = "Nutrition"
        self.icon = UIImage(named: "Nutrition")!
        self.color = .systemGreen

    }
    
    func getHandler(withIdentifier identifier: ACTIVITY_DATA_IDENTIFIER) -> ActivityDataHandler? {
        return archiveDataHandlers.filter({ $0.id == identifier }).first
    }
    
    func getValue(withIdentifier identifier: ACTIVITY_DATA_IDENTIFIER) -> Double {
        let handler = archiveDataHandlers.filter({ $0.id == identifier }).first
        return handler?.total ?? 0.0
    }
}




