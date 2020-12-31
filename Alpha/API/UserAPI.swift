//
//  UserAPI.swift
//  Alpha
//
//  Created by Garrett Head on 8/20/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class UserAPI {
    
    // Users database reference
    var USERS_DB_REF = Database.database().reference().child("users")
    
    // Reference to the current user
//    var CURRENT_USER : User? {
//        if let currentUser = Auth.auth().currentUser {
//            return currentUser
//        }
//        return nil
//    }
    
    // Observes a user based on user's uid
    func observeUser(withId uid: String, completion: @escaping (User) -> Void) {
        USERS_DB_REF.child(uid).observeSingleEvent(of: .value, with: {
            snapshot in
            if let data = snapshot.value as? [String: Any] {
                let user = User.transformUser(data: data, key: snapshot.key)
                completion(user)
            }
        })
    }

    // Observes the user currently logged into the application
    func observeCurrentUser(completion: @escaping(User) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        USERS_DB_REF.child(currentUser.uid).observeSingleEvent(of: .value, with: {
            snapshot in
            if let data = snapshot.value as? [String: Any] {
                let user = User.transformUser(data: data, key: snapshot.key)
                completion(user)
            }
        })
    }
    
    func updateTeamColor(color : String) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        USERS_DB_REF.child(currentUser.uid).updateChildValues(["teamColor":""], withCompletionBlock: { err, ref in
            if err != nil {
                return
            }
        })
    }

}
