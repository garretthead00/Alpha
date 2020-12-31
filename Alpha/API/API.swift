//
//  API.swift
//  Alpha
//
//  Created by Garrett Head on 8/20/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

struct API {
    static var User = UserAPI()
    static var Bio = BioAPI()
    static var PreferredUnits = PreferredUnitsAPI()
    static var BodyMeasurement = BodyMeasurementAPI()
    static var UserTarget = UserTargetAPI()
    static var Activity = ActivityAPI()
    static var Nutrition = NutritionAPI()
}
