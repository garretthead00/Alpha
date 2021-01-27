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
    var nutrition : String?
    var macros : String?
    var time : String?
    var ratio : String?
    var count : String?
}

extension PreferredUnits {
    static func transformUnits(data: [String: Any], key: String) -> PreferredUnits {
        let units = PreferredUnits()
        units.uid = key
        units.height = data["Height"] as? String
        units.weight = data["Weight"] as? String
        units.distance = data["Distance"] as? String
        units.volume = data["Volume"] as? String
        units.energy = data["Energy"] as? String
        units.nutrition = data["Nutrition"] as? String
        units.time = data["Time"] as? String
        units.macros = data["Macros"] as? String
        units.ratio = "%"
        units.count = ""
        return units
    }
}
