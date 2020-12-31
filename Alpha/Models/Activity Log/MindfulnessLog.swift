//
//  MindfulnessLog.swift
//  Alpha
//
//  Created by Garrett Head on 11/24/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

struct MindfulnessLog : ActivityLog {
    var id : String?
    var uid : String?
    var sessionId : String?
    var timestamp : Date?
    var mindfulMinutes : Double?
    
    init(){}
    
    init(id: String, uid: String, workoutSessionId: String, timestamp: Double, mindfulMinutes : Double){
        self.id = id
        self.uid = uid
        self.sessionId = workoutSessionId
        self.timestamp = Date(timeIntervalSince1970: timestamp)
        self.mindfulMinutes = mindfulMinutes
    }
}

extension MindfulnessLog {
    static func transformLog(data: [String: Any], key: String) -> MindfulnessLog? {
        var log = MindfulnessLog()
        log.id = key
        log.sessionId = data["sessionId"] as? String
        log.timestamp = Date(timeIntervalSince1970: data["timestamp"] as! Double)
        log.mindfulMinutes = data["mindfulMinutes"] as? Double
        return log
    }
}
