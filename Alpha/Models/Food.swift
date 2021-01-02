//
//  Food.swift
//  Alpha
//
//  Created by Garrett Head on 12/25/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

class Food {

    var name : String?
    var id : String?
    var foodType : String?
    var category : String?
    var brand : String?
    var servingSize : Double?
    var servingUnit : String?
    var householdServingSize : Double?
    var householdServingSizeUnit : String?
    var description : String?
    var nutrition : [NutritionHandler] = []
    
    init(){}
    init(id: String, name: String, foodType: String, category: String, servingSize: Double, unit: String){
        self.id = id
        self.name = name
        self.foodType = foodType
        self.category = category
        self.servingSize = servingSize
        self.servingUnit = unit
        self.nutrition = []
    }
    init(id: String, name: String, foodType: String, category: String, servingSize: Double, unit: String, nutrition: [NutritionHandler]){
        self.id = id
        self.name = name
        self.foodType = foodType
        self.category = category
        self.servingSize = servingSize
        self.servingUnit = unit
        self.nutrition = nutrition
    }

}

extension Food {

    static func transformFood(data: [String: Any], key: String) -> Food {
        let food = Food()
        food.id = key
        food.name = data["name"] as? String
        food.foodType = data["foodType"] as? String
        food.brand = data["brand"] as? String
        food.servingSize = data["servingSize"] as? Double
        food.servingUnit = data["servingUnit"] as? String
        food.householdServingSize = data["householdServingSize"] as? Double
        food.householdServingSizeUnit = data["householdServingUnit"] as? String
        food.category = data["category"] as? String
        food.description = data["description"] as? String
        return food
    }
}
