//
//  SleepLog.swift
//  Alpha
//
//  Created by Garrett Head on 11/24/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

struct SleepLog : ActivityLog {
    var id : String?
    var uid : String?
    var sessionId : String?
    var timestamp : Date?
    
    var sleepMinutes : Double?
    
    init(){}
    
    init(id: String, uid: String, workoutSessionId: String, timestamp: Double, sleepMinutes : Double){
        self.id = id
        self.uid = uid
        self.sessionId = workoutSessionId
        self.timestamp = Date(timeIntervalSince1970: timestamp)
        self.sleepMinutes = sleepMinutes
    }
}

extension SleepLog {
    static func transformLog(data: [String: Any], key: String) -> SleepLog? {
        var log = SleepLog()
        log.id = key
        log.sessionId = data["sessionId"] as? String
        log.timestamp = Date(timeIntervalSince1970: data["timestamp"] as! Double)
        log.sleepMinutes = data["sleepMinutes"] as? Double
        return log
    }
}
