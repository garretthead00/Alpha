//
//  NutritionAPI.swift
//  Alpha
//
//  Created by Garrett Head on 12/25/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

import FirebaseDatabase
import FirebaseAuth

class NutritionAPI {
    
    var FOOD_DB_REF = Database.database().reference().child("food")
    
    func observeFood(withId id: String, completion: @escaping(Food) -> Void){
        FOOD_DB_REF.child(id).observeSingleEvent(of: .value, with: {
            snapshot in
            if let data = snapshot.value as? [String:Any] {
                let food = Food.transformFood(data: data, key: snapshot.key)
                completion(food)
            }
        })
    }
    
    func createNutritionLog(foodId: String, servingSize: Double) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let now = Date().timeIntervalSince1970
        let newLogRef = API.Activity.ACTIVITYLOGS_DB_REF.child(currentUser.uid).child("nutrition").childByAutoId()
        newLogRef.setValue(["timestamp": now, "foodId": foodId, "servingSize": servingSize])
    }
    
    func createHydrationLog(servingSize: Double) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let now = Date().timeIntervalSince1970
        let newLogRef = API.Activity.ACTIVITYLOGS_DB_REF.child(currentUser.uid).child("nutrition").childByAutoId()
        newLogRef.setValue(["timestamp": now, "foodId": "water", "servingSize": servingSize, "water": servingSize])
    }
    
}
