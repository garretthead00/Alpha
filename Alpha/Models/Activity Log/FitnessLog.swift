//
//  FitnessLog.swift
//  Alpha
//
//  Created by Garrett Head on 11/24/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

struct FitnessLog : ActivityLog {
    var id : String?
    var uid : String?
    var sessionId : String?
    var timestamp : Date?
    var energyBurned : Double?
    var exerciseMinutes : Double?
    var distance : Double?
    var workoutsCompleted : Double?
    var steps : Double?
    var flightsAscended : Double?
    var standMinutes : Double?
    var work : Double?
    var cyclingDistance : Double?
    var swimDistance : Double?
    
    init(){}
    
    init(id: String, uid: String, workoutSessionId: String, timestamp: Double, energyBurned: Double, exerciseMinutes: Double, distance: Double, steps: Double, workoutsCompleted: Double){
        self.id = id
        self.uid = uid
        self.sessionId = workoutSessionId
        self.timestamp = Date(timeIntervalSince1970: timestamp)
        self.energyBurned = energyBurned
        self.exerciseMinutes = exerciseMinutes
        self.distance = distance
        self.workoutsCompleted = workoutsCompleted
        self.steps = steps
    }
}

extension FitnessLog {
    static func transformFitnessLog(data: [String: Any], key: String) -> FitnessLog? {
        var log = FitnessLog()
        log.id = key
        log.sessionId = data["sessionId"] as? String
        log.timestamp = Date(timeIntervalSince1970: data["timestamp"] as! Double)
        log.energyBurned = data["energyBurned"] as? Double
        log.exerciseMinutes = data["exerciseMinutes"] as? Double
        log.distance = data["distance"] as? Double
        //log.workoutsCompleted = data["workoutsCompleted"] as! Double
        log.steps = data["steps"] as? Double
        return log
    }
}


