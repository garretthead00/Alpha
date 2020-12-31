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
    var progress: Double?
    var healthKitIdentifiers : [String]?
    var healthKitEnabled : Bool? = false
    var activityType: ActivityType? = .mindfulness
    
    // MARK: - Sleep Activity Properties
    var mindfulMinutes : Double = 0.0
    
    // MARK: - HealthKit Properties
    var hkMindfulMinutes : Double = 0.0
    
    
    init() {
        self.name = "Mindfulness"
        self.icon = UIImage(named: "mindfulness")!
        self.color = .systemTeal
        self.healthKitIdentifiers = ["mindfulMinutes"]
        self.progress = self.mindfulMinutes
    }
    
    var logs : [MindfulnessLog] = [] {
        didSet {
            calculateTotals()
        }
    }
    
    mutating func calculateTotals(){
        mindfulMinutes = logs.reduce(0, {$0 + ($1.mindfulMinutes ?? 0.0)})
        updateActivity()
    }
    
    mutating func updateActivity(){
        progress = healthKitEnabled! ? hkMindfulMinutes : mindfulMinutes
    }
    
    mutating func setValue(forIdentifier id: String, value: Double){
        switch id {
            case "mindfulMinutes" :
                hkMindfulMinutes = value
                updateActivity()
            default : break
        }
    }
    
    func getValue(ofKey key: String) -> Double {
        var value = 0.0
        switch key {
            case "mindfulMinutes": value = healthKitEnabled! ? hkMindfulMinutes : mindfulMinutes
            default: value = 0.0
        }
        return value
    }
}


