//
//  UserTarget.swift
//  Alpha
//
//  Created by Garrett Head on 11/11/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

let TARGETS : [String] = ["bodyGoal","energyBurned", "steps", "distance", "workouts", "exerciseMinutes","energyConsumed", "protein", "fats", "carbohydrates","water","sleepMinutes", "mindfulMinutes"]
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
    
    enum TargetType {
        case fitness
        case nutrition
        case hydration
        case sleep
        case mindfulness
    }
    
    var id : ACTIVITY_DATA_IDENTIFIER
    var name : String?
    var description : String?
    var icon : UIImage?
    var unit : String?
    var value : Double?
    var targetType : TargetType?
    
    init(id: ACTIVITY_DATA_IDENTIFIER, name: String, description : String, icon : UIImage, value : Double, type: TargetType) {
        self.id = id
        self.name = name
        self.description = description
        self.icon = icon
        self.value = value
        self.targetType = type
    }
    
    init(id: ACTIVITY_DATA_IDENTIFIER, name: String, description : String, icon : UIImage, value : Double, type: TargetType, unit: String) {
        self.id = id
        self.name = name
        self.description = description
        self.icon = icon
        self.value = value
        self.targetType = type
        self.unit = unit
    }
}

extension UserTarget {
    
    static func transformUserTarget(key: String, value: Any, units: PreferredUnits) -> UserTarget? {
        switch key {
            case ACTIVITY_DATA_IDENTIFIER.EnergyBurned.rawValue: return UserTarget(id: .EnergyBurned, name: "Energy Burned", description: "Total active energy burned.", icon: UIImage(named: "energyBurned")!, value: value as! Double, type: TargetType.fitness, unit: units.energy!)
            case ACTIVITY_DATA_IDENTIFIER.Distance.rawValue: return UserTarget(id: .Distance, name: "Distance", description: "Total distance travelled", icon: UIImage(named: "distance")!, value: value as! Double, type: TargetType.fitness, unit: units.distance!)
            case ACTIVITY_DATA_IDENTIFIER.Steps.rawValue: return UserTarget(id: .Steps, name: "Steps", description: "Total steps taken.", icon: UIImage(named: "steps")!, value: value as! Double, type: TargetType.fitness, unit: units.count!)
            case ACTIVITY_DATA_IDENTIFIER.WorkoutsCompleted.rawValue: return UserTarget(id: .WorkoutsCompleted, name: "Workouts", description: "Total workouts completed", icon: UIImage(named: "workouts")!, value: value as! Double, type: TargetType.fitness, unit: units.count!)
            case ACTIVITY_DATA_IDENTIFIER.ExerciseMinutes.rawValue: return UserTarget(id: .ExerciseMinutes, name: "Exercise Minutes", description: "Total minutes exercised.", icon: UIImage(named: "exerciseMinutes")!, value: value as! Double, type: TargetType.fitness, unit: units.time!)
            case ACTIVITY_DATA_IDENTIFIER.EnergyConsumed.rawValue: return UserTarget(id: .EnergyConsumed, name: "Energy Consumed", description: "Total energy consumed", icon: UIImage(named: "energyConsumed")!, value: value as! Double, type: TargetType.nutrition, unit: units.energy!)
            case ACTIVITY_DATA_IDENTIFIER.Protein.rawValue: return UserTarget(id: .Protein, name: "Protein", description: "Total protein consumed", icon: UIImage(named: "protein")!, value: value as! Double, type: TargetType.nutrition, unit: units.ratio!)
            case ACTIVITY_DATA_IDENTIFIER.Fat.rawValue: return UserTarget(id: .Fat, name: "Fats", description: "Total fats consumed", icon: UIImage(named: "fat")!, value: value as! Double, type: TargetType.nutrition, unit: units.ratio!)
            case ACTIVITY_DATA_IDENTIFIER.Carbohydrates.rawValue: return UserTarget(id: .Carbohydrates, name: "Carbohydrates", description: "Total carbohydrates consumed", icon: UIImage(named: "carbohydrates")!, value: value as! Double, type: TargetType.nutrition, unit: units.ratio!)
            case ACTIVITY_DATA_IDENTIFIER.Water.rawValue: return UserTarget(id: .Water, name: "Water Drank", description: "Total water drank", icon: UIImage(named: "water")!, value: value as! Double, type: TargetType.hydration, unit: units.volume!)
            case ACTIVITY_DATA_IDENTIFIER.SleepMinutes.rawValue: return UserTarget(id: .SleepMinutes, name: "Sleep Minutes", description: "Total minutes slept", icon: UIImage(named: "sleep")!, value: value as! Double, type: TargetType.sleep, unit: units.time!)
            case ACTIVITY_DATA_IDENTIFIER.MindfulMinutes.rawValue: return UserTarget(id: .MindfulMinutes, name: "Mindful Minutes", description: "Total mindful minutes", icon: UIImage(named: "mindfulness")!, value: value as! Double, type: TargetType.mindfulness, unit: units.time!)
            default: return nil
        }
    }
}
