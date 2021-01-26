//
//  Archive.swift
//  Alpha
//
//  Created by Garrett Head on 1/2/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class ArchiveAPI {
    var USER_ACTIVITY_ARCHIVES = Database.database().reference().child("userActivityArchives")
    
    // Archives all ActivityIdentifier data from food.
    // "Fan-Out" nutrition data to userActivityArchives.
    func archiveData(forFood food: Food, withLogId logId: String) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        for nutrient in food.nutrition {
            let now = Date().timeIntervalSince1970
            let newLogRef = USER_ACTIVITY_ARCHIVES.child(currentUser.uid).child(nutrient.id).child(logId)
            newLogRef.setValue(["timestamp": now, "value": nutrient.value])
        }
    }
    
}


// MARK: Extension Get Methods
extension ArchiveAPI {
    
    func loadTodaysArchiveData(forIdentifiers identifiers: [ACTIVITY_DATA_IDENTIFIER], units: PreferredUnits, completion: @escaping ([ActivityDataHandler]) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let handlerFactory = ArchiveDataHandlerFactory()
        let unitFactory = PreferredUnitFactory()
        var handlers : [ActivityDataHandler] = []
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now).timeIntervalSince1970
        let dispatchGroup = DispatchGroup()
        for identifier in identifiers {
            dispatchGroup.enter()
            USER_ACTIVITY_ARCHIVES.child(currentUser.uid).child(identifier.rawValue).queryOrdered(byChild: "timestamp").queryStarting(atValue: startOfDay).queryEnding(atValue: now.timeIntervalSince1970).observe(.value, with: { snapshot in
                
                var archivedData : [Date:Double] = [:]
                let items = snapshot.children.allObjects as! [DataSnapshot]
                for (_, item) in items.enumerated() {
                    if let data = item.value as? [String:Any] {
                        let timestamp = Date(timeIntervalSince1970: data["timestamp"] as! Double)
                        let value = data["value"] as! Double
                        archivedData[timestamp] = value
                    }
                }
                
                // create data handler from archivedData dictionary
                //let handler = ArchiveDataHandler(identifier: identifier, data: archivedData)
                
                // ArchiveHandlerFactory
                var handler = handlerFactory.makeDataHandler(identifier, data: archivedData)
                handler.preferredUnit = unitFactory.createUnit(identifier, units: units)
                
                API.UserTarget.observeTarget(identifier, completion: { target in
                    handler.target = target
                    handlers.append(handler)
                    dispatchGroup.leave()
                })
                
                
            })
        }
        
        dispatchGroup.notify(queue: .main, execute: {
            completion(handlers)
        })
        
    }
    
    private func getPreferredUnits(){
        
    }
    
    func loadArchiveData(forIdentifiers identifiers: [ACTIVITY_DATA_IDENTIFIER], completion: @escaping ([ActivityDataHandler]) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let handlerFactory = ArchiveDataHandlerFactory()
        var handlers : [ActivityDataHandler] = []
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now).timeIntervalSince1970
        let dispatchGroup = DispatchGroup()
       
        for identifier in identifiers {
            dispatchGroup.enter()
            
            API.UserTarget.observeUserTarget(forIdentifier: identifier, completion: { target in
                self.USER_ACTIVITY_ARCHIVES.child(currentUser.uid).child(identifier.rawValue).queryOrdered(byChild: "timestamp").queryStarting(atValue: startOfDay).queryEnding(atValue: now.timeIntervalSince1970).observe(.value, with: { snapshot in
                    var archivedData : [Date:Double] = [:]
                    let items = snapshot.children.allObjects as! [DataSnapshot]
                    for (_, item) in items.enumerated() {
                        if let data = item.value as? [String:Any] {
                            let timestamp = Date(timeIntervalSince1970: data["timestamp"] as! Double)
                            let value = data["value"] as! Double
                            archivedData[timestamp] = value
                        }
                    }
                    
                    // create data handler from archivedData dictionary
                    let handler = handlerFactory.makeDataHandler(identifier, data: archivedData)
                    
                    handlers.append(handler)
                   dispatchGroup.leave()
                })
            })
        }
        
        
        dispatchGroup.notify(queue: .main, execute: {
            completion(handlers)
        })
        
    }
    

    
}
