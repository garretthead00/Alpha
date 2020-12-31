//
//  ActivityAPI.swift
//  Alpha
//
//  Created by Garrett Head on 11/29/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

import FirebaseDatabase
import FirebaseAuth

class ActivityAPI {
    var ACTIVITYLOGS_DB_REF = Database.database().reference().child("activityLogs")
    
    
    func observeActivityLogs(forActivity activity: String, completion: @escaping([ActivityLog]) -> Void) {
        var logs : [ActivityLog] = []
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now).timeIntervalSince1970
        print("start of day: \(startOfDay) and now: \(now.timeIntervalSince1970)")
        guard let currentUser = Auth.auth().currentUser else { return }
        ACTIVITYLOGS_DB_REF.child(currentUser.uid).child(activity).queryOrdered(byChild: "timestamp").queryStarting(atValue: startOfDay).queryEnding(atValue: now.timeIntervalSince1970).observe(.value, with: { snapshot in
            let items = snapshot.children.allObjects as! [DataSnapshot]
            for (_, item) in items.enumerated() {
                if let data = item.value as? [String:Any]{
                    switch activity {
                        case "fitness" : if let log = FitnessLog.transformFitnessLog(data: data, key: item.key) { logs.append(log) }
                        case "nutrition" : if let log = NutritionLog.transformLog(data: data, key: item.key) { logs.append(log) }
                        case "hydration" : if let log = NutritionLog.transformLog(data: data, key: item.key) { logs.append(log) }
                        case "sleep" : if let log = SleepLog.transformLog(data: data, key: item.key) { logs.append(log) }
                        case "mindfulness" : if let log = MindfulnessLog.transformLog(data: data, key: item.key) { logs.append(log) }
                        default : break
                    }
                }
            }
            completion(logs)
        })
    }
    
    // Returns the User Fitness Logs.
    func observeFitnessLogs( completion: @escaping (FitnessLog) -> Void) {
        guard let currentUser = Auth.auth().currentUser else { return }
        ACTIVITYLOGS_DB_REF.child(currentUser.uid).child("fitness").observe(.value, with: { snapshot in
            let items = snapshot.children.allObjects as! [DataSnapshot]
            for (_, item) in items.enumerated() {
                if let data = item.value as? [String:Any]{
                    if let log = FitnessLog.transformFitnessLog(data: data, key: item.key) {
                        completion(log)
                    }
                }
            }
        })
    }
    
    // Returns the User Nutrition Logs.
    func observeTodaysNutritionLogs(completion: @escaping ([NutritionLog]) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        var logs : [NutritionLog] = []
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now).timeIntervalSince1970
        print("ActivityAPI ---observeTodaysNutritionLogs...")
        print("start of day: \(startOfDay) and now: \(now.timeIntervalSince1970)")
        ACTIVITYLOGS_DB_REF.child(currentUser.uid).child("nutrition").queryOrdered(byChild: "timestamp").queryStarting(atValue: startOfDay).queryEnding(atValue: now.timeIntervalSince1970).observe(.value, with: { snapshot in
            let items = snapshot.children.allObjects as! [DataSnapshot]
            let dispatchGroup = DispatchGroup()
            for (_, item) in items.enumerated() {
                dispatchGroup.enter()
                if let data = item.value as? [String:Any] {
                    if let foodId = data["foodId"] as? String {
                        API.Nutrition.observeFood(withId: "\(foodId)", completion: {
                            food in
                            if let log = NutritionLog.transformLog(data: data, food: food, key: item.key) { logs.append(log) }
                            dispatchGroup.leave()
                        })
                    }
                }
            }
            dispatchGroup.notify(queue: .main, execute: { completion(logs) })
            completion(logs)
        })
    }
    
    // Returns the User Hydration Logs.
    func observeHydrationLogs( completion: @escaping (NutritionLog) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        ACTIVITYLOGS_DB_REF.child(currentUser.uid).child("hydration").observe(.value, with: { snapshot in
            let items = snapshot.children.allObjects as! [DataSnapshot]
            for (_, item) in items.enumerated() {
                if let data = item.value as? [String:Any]{
                    if let log = NutritionLog.transformLog(data: data, key: item.key) {
                        completion(log)
                    }
                }
            }
        })
    }
    func observeSleepLogs( completion: @escaping (SleepLog) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        ACTIVITYLOGS_DB_REF.child(currentUser.uid).child("sleep").observe(.value, with: { snapshot in
            let items = snapshot.children.allObjects as! [DataSnapshot]
            for (_, item) in items.enumerated() {
                if let data = item.value as? [String:Any]{
                    if let log = SleepLog.transformLog(data: data, key: item.key) {
                        completion(log)
                    }
                }
            }
        })
    }
    
    func observeMindfulnessLogs( completion: @escaping (MindfulnessLog) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        ACTIVITYLOGS_DB_REF.child(currentUser.uid).child("mindfulness").observe(.value, with: { snapshot in
            let items = snapshot.children.allObjects as! [DataSnapshot]
            for (_, item) in items.enumerated() {
                if let data = item.value as? [String:Any]{
                    if let log = MindfulnessLog.transformLog(data: data, key: item.key) {
                        completion(log)
                    }
                }
            }
        })
    }
    
}
