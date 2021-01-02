//
//  UserTargetAPI.swift
//  Alpha
//
//  Created by Garrett Head on 11/15/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class UserTargetAPI {
    
    // Bio database reference
    var USERTARGETS_DB_REF = Database.database().reference().child("userTargets")
    
    func observeUserTargets(completion: @escaping(UserTarget?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        API.PreferredUnits.observePreferredUnits(completion: {
            units in
            self.USERTARGETS_DB_REF.child(currentUser.uid).observeSingleEvent(of: .value, with: { snapshot in
                for child in snapshot.children.allObjects as! [DataSnapshot] {
                    let target = UserTarget.transformUserTarget(key: child.key, value: child.value!, units: units)
                    completion(target)
                }
            })
        })
        
    }
    
    func observeTargets(completion: @escaping([UserTarget]) -> Void) {
        var targets : [UserTarget] = []
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        API.PreferredUnits.observePreferredUnits(completion: {
            units in
            self.USERTARGETS_DB_REF.child(currentUser.uid).observe(.value, with: {
                snapshot in
                let items = snapshot.children.allObjects as! [DataSnapshot]
                for (_, item) in items.enumerated() {
                    if let target = UserTarget.transformUserTarget(key: item.key, value: item.value as Any, units: units) {
                        targets.append(target)
                    }
                }
                completion(targets)
            })
        })
    }
    
    func updateUserTarget(target: String, value: Double){
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        USERTARGETS_DB_REF.child(currentUser.uid).updateChildValues([target:value], withCompletionBlock: {
            err, ref in
            if err != nil {
                return
            }
            print("Successfully updated target \(target) with value \(value) in Firebase!")
        })
    }
    
    
    // Creates the first instance of the UserTarget with default values.
    // Triggered on registration of user account.
    func initializeUserTargets(){
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        USERTARGETS_DB_REF.child(currentUser.uid).updateChildValues(DEFAULT_TARGETS, withCompletionBlock: {
            err, ref in
            if err != nil {
                return
            }
            print("Successfully initialized UserTargets in Firebase!")
        })
    }
    
    func updateTargets(targets: [UserTarget]) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        var data : [String: Any] = [:]
        for target in targets {
            data[target.id] = target.value
        }
        USERTARGETS_DB_REF.child(currentUser.uid).updateChildValues(data, withCompletionBlock: {
            err, ref in
            if err != nil {
                return
            }
            print("Successfully updated UserTargets in Firebase!")
        })
        
    }
}