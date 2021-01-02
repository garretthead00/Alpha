//
//  NutritionHandler.swift
//  Alpha
//
//  Created by Garrett Head on 1/2/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//
//  NutritionHandler manages the nutrition value of each nutrient associated with a Food.

import Foundation

struct NutritionHandler {
    var id : String
    var name : String
    var value : Double
    var unit : String
}

extension NutritionHandler {
    init(nutrient: String) {
        self.id = nutrient
        self.name = "name"
        self.value = 0.0
        self.unit = "unit"
    }
}
