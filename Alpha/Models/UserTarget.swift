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

class UserTarget {
    
    enum TargetType {
        case body
        case fitness
        case nutrition
        case hydration
        case sleep
        case mindfulness
    }
    
    var id : String
    var name : String?
    var description : String?
    var icon : UIImage?
    var unit : String?
    var value : Any?
    var targetType : TargetType?
    
    init(id: String, name: String, description : String, icon : UIImage, value : Double, type: TargetType) {
        self.id = id
        self.name = name
        self.description = description
        self.icon = icon
        self.value = value
        self.targetType = type
    }
    
    init(id: String, name: String, description : String, icon : UIImage, value : String, type: TargetType) {
        self.id = id
        self.name = name
        self.description = description
        self.icon = icon
        self.value = value
        self.targetType = type
    }
    
    init(id: String, name: String, description : String, icon : UIImage, value : Double, type: TargetType, unit: String) {
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
            case "bodyGoal" : return UserTarget(id: key, name: "Body Goal", description: "Body goal target.", icon: UIImage(named: "target")!, value: value as! String, type: TargetType.body)
            case "energyBurned": return UserTarget(id: key, name: "Energy Burned", description: "Total active energy burned.", icon: UIImage(named: "energyBurned")!, value: value as! Double, type: TargetType.fitness, unit: units.energy!)
            case "distance": return UserTarget(id: key, name: "Distance", description: "Total distance travelled", icon: UIImage(named: "distance")!, value: value as! Double, type: TargetType.fitness, unit: units.distance!)
            case "steps": return UserTarget(id: key, name: "Steps", description: "Total steps taken.", icon: UIImage(named: "steps")!, value: value as! Double, type: TargetType.fitness, unit: units.count!)
            case "workouts": return UserTarget(id: key, name: "Workouts", description: "Total workouts completed", icon: UIImage(named: "workouts")!, value: value as! Double, type: TargetType.fitness, unit: units.count!)
            case "exerciseMinutes": return UserTarget(id: key, name: "Exercise Minutes", description: "Total minutes exercised.", icon: UIImage(named: "exerciseMinutes")!, value: value as! Double, type: TargetType.fitness, unit: units.time!)
            case "energyConsumed": return UserTarget(id: key, name: "Energy Consumed", description: "Total energy consumed", icon: UIImage(named: "energyConsumed")!, value: value as! Double, type: TargetType.nutrition, unit: units.energy!)
            case "protein": return UserTarget(id: key, name: "Protein", description: "Total protein consumed", icon: UIImage(named: "protein")!, value: value as! Double, type: TargetType.nutrition, unit: units.ratio!)
            case "fats": return UserTarget(id: key, name: "Fats", description: "Total fats consumed", icon: UIImage(named: "fat")!, value: value as! Double, type: TargetType.nutrition, unit: units.ratio!)
            case "carbohydrates": return UserTarget(id: key, name: "Carbohydrates", description: "Total carbohydrates consumed", icon: UIImage(named: "carbohydrates")!, value: value as! Double, type: TargetType.nutrition, unit: units.ratio!)
            case "water": return UserTarget(id: key, name: "Water Drank", description: "Total water drank", icon: UIImage(named: "water")!, value: value as! Double, type: TargetType.hydration, unit: units.volume!)
            case "sleepMinutes": return UserTarget(id: key, name: "Sleep Minutes", description: "Total minutes slept", icon: UIImage(named: "sleep")!, value: value as! Double, type: TargetType.sleep, unit: units.time!)
            case "mindfulMinutes": return UserTarget(id: key, name: "Mindful Minutes", description: "Total mindful minutes", icon: UIImage(named: "mindfulness")!, value: value as! Double, type: TargetType.mindfulness, unit: units.time!)
            default: return nil
        }
    }
}
