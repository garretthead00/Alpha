//
//  MindfulnessActivity.swift
//  Alpha
//
//  Created by Garrett Head on 11/24/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

import UIKit

struct MindfulnessActivity : Activity {
    
    // MARK: - Activity Properties
    var name: String
    var icon: UIImage
    var color: UIColor
    var progress: Double? {
        let handler = archiveDataHandlers.filter({ $0.id == progressIdentifier }).first
        return handler?.total
    }
    var healthKitIdentifiers : [String]?
    var healthKitEnabled : Bool? = false
    var activityType: ActivityType? = .mindfulness
    
    // MARK: - Sleep Activity Properties
    var mindfulMinutes : Double = 0.0
    
    // MARK: - HealthKit Properties
    var hkMindfulMinutes : Double = 0.0
    
    var logs : [MindfulnessLog] = []
    
    var progressIdentifier : ACTIVITY_DATA_IDENTIFIER = .MindfulMinutes
    var activityDataIdentifiers : [ACTIVITY_DATA_IDENTIFIER] = [.MindfulMinutes]
    var archiveDataHandlers : [ActivityDataHandler] = []
    
    init() {
        self.name = "Mindfulness"
        self.icon = UIImage(named: "mindfulness")!
        self.color = .systemTeal
        self.healthKitIdentifiers = ["mindfulMinutes"]
    }

    func getHandler(withIdentifier identifier: ACTIVITY_DATA_IDENTIFIER) -> ActivityDataHandler? {
        return archiveDataHandlers.filter({ $0.id == identifier }).first
    }
    func getValue(withIdentifier identifier: ACTIVITY_DATA_IDENTIFIER) -> Double {
        let handler = archiveDataHandlers.filter({ $0.id == identifier }).first
        return handler?.total ?? 0.0
    }
    
    
}


