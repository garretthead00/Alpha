//
//  PreferredUnits.swift
//  Alpha
//
//  Created by Garrett Head on 9/12/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

class PreferredUnits {
    var uid : String?
    var weight : String?
    var height : String?
    var volume : String?
    var energy : String?
    var distance : String?
    var time : String?
    var ratio : String?
    var count : String?
}

extension PreferredUnits {
    static func transformUnits(data: [String: Any], key: String) -> PreferredUnits {
        let units = PreferredUnits()
        units.uid = key
        units.height = data["height"] as? String
        units.weight = data["weight"] as? String
        units.distance = data["distance"] as? String
        units.volume = data["volume"] as? String
        units.energy = data["energy"] as? String
        units.time = "min"
        units.ratio = "%"
        units.count = ""
        return units
    }
}
