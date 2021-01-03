//
//  SleepActivity.swift
//  Alpha
//
//  Created by Garrett Head on 11/24/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

struct SleepActivity : Activity {

    // MARK: - Activity Properties
    var name: String
    var icon: UIImage
    var color: UIColor
    var progress: Double? {
        let handler = archiveDataHandlers.filter({ $0.id == progressIdentifier }).first
        return handler?.total
    }
    var activityType: ActivityType? = .sleep
    
    // MARK: - Sleep Activity Properties
    var healthKitIdentifiers : [String]?
    var sleepMinutes : Double = 0.0
    
    // MARK: - HealthKit properties
    var healthKitEnabled : Bool? = false
    var hkSleepMinutes : Double = 0.0
    
    var logs : [SleepLog] = []
    
    
    var progressIdentifier : ACTIVITY_DATA_IDENTIFIER = .SleepMinutes
    var activityDataIdentifiers : [ACTIVITY_DATA_IDENTIFIER] = [.SleepMinutes]
    var archiveDataHandlers : [ArchiveDataHandler] = []
    
    
    init() {
        self.name = "Sleep"
        self.icon = UIImage(named: "sleep")!
        self.color = .systemPurple
        self.healthKitIdentifiers = ["sleepMinutes"]
    }
    
    
    func getHandler(withIdentifier identifier: ACTIVITY_DATA_IDENTIFIER) -> ArchiveDataHandler {
        return archiveDataHandlers.filter({ $0.id == identifier }).first!
    }
    func getValue(withIdentifier identifier: ACTIVITY_DATA_IDENTIFIER) -> Double {
        let handler = archiveDataHandlers.filter({ $0.id == identifier }).first
        return handler?.total ?? 0.0
    }

}

