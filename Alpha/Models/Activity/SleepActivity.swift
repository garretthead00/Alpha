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
    var progress: Double?
    var activityType: ActivityType? = .sleep
    
    // MARK: - Sleep Activity Properties
    var healthKitIdentifiers : [String]?
    var sleepMinutes : Double = 0.0
    
    // MARK: - HealthKit properties
    var healthKitEnabled : Bool? = false
    var hkSleepMinutes : Double = 0.0
    
    init() {
        self.name = "Sleep"
        self.icon = UIImage(named: "sleep")!
        self.color = .systemPurple
        self.healthKitIdentifiers = ["sleepMinutes"]
        self.progress = self.sleepMinutes
    }
    
    var logs : [SleepLog] = [] {
        didSet {
            calculateTotals()
        }
    }
    
    mutating func calculateTotals(){
        sleepMinutes = logs.reduce(0, {$0 + ($1.sleepMinutes ?? 0.0)})
        updateActivity()
    }
    
    mutating func updateActivity(){
        progress = healthKitEnabled! ? hkSleepMinutes : sleepMinutes
    }

    mutating func setValue(forIdentifier id: String, value: Double){
        switch id {
            case "sleepMinutes" :
                hkSleepMinutes = value
                updateActivity()
            default : break
        }
    }
    
    func getValue(ofKey key: String) -> Double {
        var value = 0.0
        switch key {
            case "sleepMinutes": value = healthKitEnabled! ? hkSleepMinutes : sleepMinutes
            default: value = 0.0
        }
        return value
    }
}

