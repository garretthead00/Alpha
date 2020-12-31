//
//  Bio.swift
//  Alpha
//
//  Created by Garrett Head on 8/21/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

class Bio {
    var uid : String?
    var firstName : String?
    var lastName : String?
    var dateOfBirth : Double?
    var biologicalSex : String?
    var bodyType : String?
    var activityLevel : String?
    var height : Double?
    var weight : Double?
    var bodyFat : Double?
    
}

extension Bio {
    static func transformBio(data: [String: Any], key: String) -> Bio {
        let bio = Bio()
        bio.uid = key
        bio.firstName = data["firstName"] as? String
        bio.lastName = data["lastName"] as? String
        bio.biologicalSex = data["biologicalSex"] as? String
        bio.dateOfBirth = data["dateOfBirth"] as? Double
        bio.bodyType = data["bodyType"] as? String
        bio.activityLevel = data["activityLevel"] as? String
//        bio.height = data["height"] as? Double
//        bio.weight = data["weight"] as? Double
//        bio.bodyFat = data["bodyFat"] as? Double
        return bio
    }
    
}
