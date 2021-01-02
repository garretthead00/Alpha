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
