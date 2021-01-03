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
    var logs : [NutritionLog] = []
    
    var progressIdentifier : ACTIVITY_DATA_IDENTIFIER = .EnergyConsumed
    var activityDataIdentifiers : [ACTIVITY_DATA_IDENTIFIER] = []
    var archiveDataHandlers : [ArchiveDataHandler] = []
    
    init() {
        self.name = "Nutrition"
        self.icon = UIImage(named: "Nutrition")!
        self.color = .systemGreen

    }
    
    func getValue(ofKey key: String) -> Double {
        var value : ACTIVITY_DATA_IDENTIFIER = .EnergyConsumed
        switch key {
            case "energyConsumed": value = .EnergyConsumed
            case "protein": value = .Protein
            case "fats": value = .Fat
            case "carbohydrates": value = .Carbohydrates
            default: break
        }
        let handler = archiveDataHandlers.filter({ $0.id == value }).first
        return handler?.total ?? 0.0
    }
    
    func getHandler(withIdentifier identifier: ACTIVITY_DATA_IDENTIFIER) -> ArchiveDataHandler {
        return archiveDataHandlers.filter({ $0.id == identifier }).first!
    }
    
    func getValue(withIdentifier identifier: ACTIVITY_DATA_IDENTIFIER) -> Double {
        let handler = archiveDataHandlers.filter({ $0.id == identifier }).first
        return handler?.total ?? 0.0
    }
}




