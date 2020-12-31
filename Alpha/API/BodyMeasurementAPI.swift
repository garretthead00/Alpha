//
//  BodyMeasurementAPI.swift
//  Alpha
//
//  Created by Garrett Head on 9/14/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class BodyMeasurementAPI {
    // Bio database reference
       var BODYMEASUREMENT_DB_REF = Database.database().reference().child("bodyMeasurement")
    
    func observeBodyMeasurements(forAttribute attribute: String, completion: @escaping(BodyMeasurement) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        BODYMEASUREMENT_DB_REF.child(currentUser.uid).child(attribute).queryOrdered(byChild: "date").queryLimited(toLast: 25).observe(.childAdded, with: {
            snapshot in
            if let data = snapshot.value as? [String : Any] {
                let measurement = BodyMeasurement.transformBodyMeasurement(data: data, key: snapshot.key)
                completion(measurement)
            }
        })
    }
    func observeCurrentBodyMeasurement(forAttribute attribute: String, completion: @escaping(BodyMeasurement) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        BODYMEASUREMENT_DB_REF.child(currentUser.uid).child(attribute).queryOrdered(byChild: "date").queryLimited(toLast: 1).observe(.childAdded, with: {
            snapshot in
            if let data = snapshot.value as? [String : Any] {
                let measurement = BodyMeasurement.transformBodyMeasurement(data: data, key: snapshot.key)
                completion(measurement)
            }
        })
    }
    
    func updateBodyMeasurement(forAttribute attribute: String, date : Double, value: Double){
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        BODYMEASUREMENT_DB_REF.child(currentUser.uid).child(attribute).childByAutoId().updateChildValues(["date": date, "value": value], withCompletionBlock: {
            err, ref in
            if err != nil {
                return
            }
            print("firebase updated!")
        })
        
    }
    
    func removeBodyMeasurement(forAttribute attribute: String, withId id: String){
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        BODYMEASUREMENT_DB_REF.child(currentUser.uid).child(attribute).child(id).removeValue()
    }
}
