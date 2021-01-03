//
//  BioAPI.swift
//  Alpha
//
//  Created by Garrett Head on 8/21/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class BioAPI {
    
    // Bio database reference
    var BIO_DB_REF = Database.database().reference().child("bio")
    
    // Observes the user currently logged into the application
    func observeBio(completion: @escaping(Bio) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        BIO_DB_REF.child(currentUser.uid).observeSingleEvent(of: .value, with: {
            snapshot in
            if let data = snapshot.value as? [String: Any] {
                let bio = Bio.transformBio(data: data, key: snapshot.key)
                completion(bio)
            }
        })
    }
    
    func fetchBodyGoal(completion: @escaping(String) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        BIO_DB_REF.child(currentUser.uid).child("bodyGoal").observeSingleEvent(of: .value, with: {
            snapshot in
            if let data = snapshot.value as? String {
                completion(data)
            }
        })
    }
    
    func updateBio(withKey key: String, value: Any) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        BIO_DB_REF.child(currentUser.uid).updateChildValues([key:value], withCompletionBlock: {
            err, ref in
            if err != nil {
                return
            }
            print("firebase updated!")
        })
    }
    
    func updateBio(firstName: String, lastName: String, dateOfBirth: Double, biologicalSex: String, bodyType: String, activityLevel: String) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        BIO_DB_REF.child(currentUser.uid).updateChildValues([
            "firstName" : firstName,
            "lastName" : lastName,
            "dateOfBirth" : dateOfBirth,
            "biologicalSex" : biologicalSex,
            "bodyType" : bodyType,
            "activityLevel" : activityLevel
        ], withCompletionBlock: { err, ref in
            if err != nil  {
                return
            }
            print("save successful")
        })
    }
    

    
    
}
