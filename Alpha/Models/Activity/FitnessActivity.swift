//
//  FitnessActivity.swift
//  Alpha
//
//  Created by Garrett Head on 11/20/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

struct FitnessActivity : Activity {
    
    // MARK: - Activity properties
    var name: String
    var icon: UIImage
    var color: UIColor
    var progress: Double?
    var activityType: ActivityType? = .fitness
    
    // MARK: - Fitness Activity properties
    var healthKitIdentifiers : [String]?
    var totalActiveCaloriesBurned : Double = 0.0
    var totalRestingCaloriesBurned : Double = 0.0
    var totalCaloriesBurned : Double {
        return (totalActiveCaloriesBurned + totalRestingCaloriesBurned)
    }
    var exerciseMinutes : Double = 0.0
    var distance : Double = 0.0
    var workoutsCompleted : Int {
        return logs.count
    }
    var steps : Double = 0.0
    var flightsAscended : Double = 0.0
    var standMinutes : Double = 0.0
    var work : Double = 0.0
    var cyclingDistance : Double = 0.0
    var swimDistance : Double = 0.0
    
    var logs : [FitnessLog] = [] {
        didSet {
            calculateTotals()
        }
    }
    
    // MARK: - HealthKit properties
    var healthKitEnabled : Bool? = false
    var hkEnergyBurned : Double = 0.0
    var hkStepCount : Double = 0.0
    
    init() {
        self.name = "Fitness"
        self.icon = UIImage(named: "Fitness")!
        self.color = .systemRed
        self.healthKitIdentifiers = ["energyBurned", "steps"]
        self.progress = self.totalActiveCaloriesBurned
    }

    
    // Using the fitnessLogs, calculate the total values for each Fitness Activity property.
    mutating func calculateTotals(){
        totalActiveCaloriesBurned = logs.reduce(0, {$0 + ($1.energyBurned ?? 0.0)})
        distance = logs.reduce(0, {$0 + ($1.distance ?? 0.0)})
        steps = logs.reduce(0, {$0 + ($1.steps  ?? 0.0)})
        exerciseMinutes = logs.reduce(0, {$0 + ($1.exerciseMinutes  ?? 0.0)})
        updateActivity()
    }
    
    func getValue(ofKey key: String) -> Double {
        var value = 0.0
        switch key {
            case "energyBurned": value = healthKitEnabled! ? hkEnergyBurned : totalActiveCaloriesBurned
            case "steps": value = healthKitEnabled! ? hkStepCount : steps
            case "distance": value = distance
            case "exerciseMinutes": value = exerciseMinutes
            case "flightsAscended": value = flightsAscended
            case "standMinutes": value = standMinutes
            case "workouts": value = Double(workoutsCompleted)
            default: value = 0.0
        }
        return value
    }
    
    mutating func setValue(forIdentifier id: String, value: Double){
        switch id {
            case "energyBurned" :
                hkEnergyBurned = value
                updateActivity()
            case "steps" :
                hkStepCount = value

            default : break
        }
    }
    
    mutating func updateActivity(){
        progress = healthKitEnabled! ? hkEnergyBurned : totalActiveCaloriesBurned
    }
}

