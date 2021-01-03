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
    var progress: Double? {
        let handler = archiveDataHandlers.filter({ $0.id == progressIdentifier }).first
        return handler?.total
    }
    var activityType: ActivityType? = .fitness
    var healthKitIdentifiers : [String]?
    
    var logs : [FitnessLog] = []
    var progressIdentifier : ACTIVITY_DATA_IDENTIFIER = .EnergyBurned
    var activityDataIdentifiers : [ACTIVITY_DATA_IDENTIFIER] = [.EnergyBurned, .ExerciseMinutes, .Steps, .Distance, .WorkoutsCompleted]
    var archiveDataHandlers : [ArchiveDataHandler] = []
    
    // MARK: - HealthKit properties
    var healthKitEnabled : Bool? = false
    var hkEnergyBurned : Double = 0.0
    var hkStepCount : Double = 0.0
    
    init() {
        self.name = "Fitness"
        self.icon = UIImage(named: "Fitness")!
        self.color = .systemRed
    }


    
    func getValue(ofKey key: String) -> Double {
        var value : ACTIVITY_DATA_IDENTIFIER = .EnergyBurned
        switch key {
            case "energyBurned": value = .EnergyBurned
            case "steps": value = .Steps
            case "distance": value = .Distance
            case "exerciseMinutes": value = .ExerciseMinutes
            case "workouts": value = .WorkoutsCompleted
            default: break
        }
        let handler = archiveDataHandlers.filter({ $0.id == value }).first
        return handler?.total ?? 0.0
    }
    
    mutating func setValue(forIdentifier id: String, value: Double){
        switch id {
            case "energyBurned" :
                hkEnergyBurned = value
            case "steps" :
                hkStepCount = value

            default : break
        }
    }

    func getHandler(withIdentifier identifier: ACTIVITY_DATA_IDENTIFIER) -> ArchiveDataHandler {
        return archiveDataHandlers.filter({ $0.id == identifier }).first!
    }
    
    func getValue(withIdentifier identifier: ACTIVITY_DATA_IDENTIFIER) -> Double {
        let handler = archiveDataHandlers.filter({ $0.id == identifier }).first
        return handler?.total ?? 0.0
    }
}

