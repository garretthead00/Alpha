//
//  PreferredUnits.swift
//  Alpha
//
//  Created by Garrett Head on 9/12/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class PreferredUnitsAPI {
    var PREFERRED_UNITS_DB_REF = Database.database().reference().child("preferredUnits")
    
    func observePreferredUnits(completion: @escaping (PreferredUnits) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        PREFERRED_UNITS_DB_REF.child(currentUser.uid).observeSingleEvent(of: .value, with: {
            snapshot in
            if let data = snapshot.value as? [String: Any] {
                let units = PreferredUnits.transformUnits(data: data, key: snapshot.key)
                completion(units)
            }
        })
    }
    
    func observePreferredUnit(forKey key: String, completion: @escaping (String) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        PREFERRED_UNITS_DB_REF.child(currentUser.uid).child(key).observeSingleEvent(of: .value, with: { snapshot in
            if let data = snapshot.value as? String {
                completion(data)
            }
        })
    }
    
    func updatePreferredUnits(withKey key: String, value: Any) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        PREFERRED_UNITS_DB_REF.child(currentUser.uid).updateChildValues([key:value], withCompletionBlock: {
            err, ref in
            if err != nil {
                return
            }
        })
    }
    
    func updatePreferredUnits(units: PreferredUnits) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        PREFERRED_UNITS_DB_REF.child(currentUser.uid).updateChildValues([
            "weight" : units.weight!,
            "height" : units.height!,
            "distance" : units.distance!,
            "energy" : units.energy!,
            "volume" : units.volume!
        ], withCompletionBlock: {
            err, ref in
            if err != nil {
                return
            }
        })
    }
}
