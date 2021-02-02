//
//  UserTarget.swift
//  Alpha
//
//  Created by Garrett Head on 11/11/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

let DEFAULT_TARGETS : [String : Any] = ["bodyGoal": "Maintain",
                                           "energyBurned": 0.0,
                                           "steps": 0.0,
                                           "distance": 0.0,
                                           "workouts": 0.0,
                                           "exerciseMinutes": 0.0,
                                           "energyConsumed": 0.0,
                                           "protein": 0.0,
                                           "fats": 0.0,
                                           "carbohydrates": 0.0,
                                           "water": 0.0,
                                           "sleepMinutes": 0.0,
                                           "mindfulMinutes": 0.0]

let USER_TARGET_IDENTIFIERS : [ACTIVITY_DATA_IDENTIFIER] = [.EnergyBurned, .Steps, .Distance, .WorkoutsCompleted, .ExerciseMinutes, .EnergyConsumed, .Protein, .Fat, .Carbohydrates, .Water, .SleepMinutes, .MindfulMinutes]
let USER_DEFAULT_TARGETS : [String : Double] = [
    ACTIVITY_DATA_IDENTIFIER.EnergyBurned.rawValue: 0.0,
    ACTIVITY_DATA_IDENTIFIER.Steps.rawValue: 0.0,
    ACTIVITY_DATA_IDENTIFIER.Distance.rawValue: 0.0,
    ACTIVITY_DATA_IDENTIFIER.WorkoutsCompleted.rawValue: 0.0,
    ACTIVITY_DATA_IDENTIFIER.ExerciseMinutes.rawValue: 0.0,
    ACTIVITY_DATA_IDENTIFIER.EnergyConsumed.rawValue: 0.0,
    ACTIVITY_DATA_IDENTIFIER.Protein.rawValue: 0.0,
    ACTIVITY_DATA_IDENTIFIER.Fat.rawValue: 0.0,
    ACTIVITY_DATA_IDENTIFIER.Carbohydrates.rawValue: 0.0,
    ACTIVITY_DATA_IDENTIFIER.Water.rawValue: 0.0,
    ACTIVITY_DATA_IDENTIFIER.SleepMinutes.rawValue: 0.0,
    ACTIVITY_DATA_IDENTIFIER.MindfulMinutes.rawValue: 0.0]

class UserTarget {

    
    var id : ACTIVITY_DATA_IDENTIFIER
    var value : Double?
    var targetType : ActivityType?
    
    init(id: ACTIVITY_DATA_IDENTIFIER, name: String, description : String, icon : UIImage, value : Double, type: ActivityType) {
        self.id = id
        self.value = value
        self.targetType = type
    }
    
    init(id: ACTIVITY_DATA_IDENTIFIER, value : Double, type: ActivityType) {
        self.id = id
        self.value = value
        self.targetType = type
    }
}

extension UserTarget {
    
    // map string key to the activity identifier. use the Target factory method to create the 
    static func transformUserTarget(key: String, value: Double) -> UserTarget? {
        switch key {
            case ACTIVITY_DATA_IDENTIFIER.EnergyBurned.rawValue: return UserTarget(id: .EnergyBurned, value: value, type: ActivityType.fitness)
            case ACTIVITY_DATA_IDENTIFIER.Distance.rawValue: return UserTarget(id: .Distance, value: value, type: ActivityType.fitness)
            case ACTIVITY_DATA_IDENTIFIER.Steps.rawValue: return UserTarget(id: .Steps, value: value, type: ActivityType.fitness)
            case ACTIVITY_DATA_IDENTIFIER.WorkoutsCompleted.rawValue: return UserTarget(id: .WorkoutsCompleted, value: value, type: ActivityType.fitness)
            case ACTIVITY_DATA_IDENTIFIER.ExerciseMinutes.rawValue: return UserTarget(id: .ExerciseMinutes, value: value, type: ActivityType.fitness)
            case ACTIVITY_DATA_IDENTIFIER.EnergyConsumed.rawValue: return UserTarget(id: .EnergyConsumed, value: value, type: ActivityType.nutrition)
            case ACTIVITY_DATA_IDENTIFIER.Protein.rawValue: return UserTarget(id: .Protein, value: value, type: ActivityType.nutrition)
            case ACTIVITY_DATA_IDENTIFIER.Fat.rawValue: return UserTarget(id: .Fat, value: value, type: ActivityType.nutrition)
            case ACTIVITY_DATA_IDENTIFIER.Carbohydrates.rawValue: return UserTarget(id: .Carbohydrates, value: value, type: ActivityType.nutrition)
            case ACTIVITY_DATA_IDENTIFIER.Water.rawValue: return UserTarget(id: .Water, value: value, type: ActivityType.hydration)
            case ACTIVITY_DATA_IDENTIFIER.SleepMinutes.rawValue: return UserTarget(id: .SleepMinutes, value: value, type: ActivityType.sleep)
            case ACTIVITY_DATA_IDENTIFIER.MindfulMinutes.rawValue: return UserTarget(id: .MindfulMinutes, value: value, type: ActivityType.mindfulness)
            default: return nil
        }
    }
}
