//
//  ActivityLogViewModel.swift
//  Alpha
//
//  Created by Garrett Head on 12/27/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

class ActivityLogViewModel {
    
    var name : String
    var timestamp : String
    var value : Double
    var unit : String

    init(log: ActivityLog) {
        self.name = ""
        self.timestamp = ""
        self.value = 0.0
        self.unit = ""
        if let log = log as? NutritionLog, let food = log.food {
            if let name = food.name { self.name = name }
            if let value = log.servingSize { self.value = value }
            if let unit = log.servingUnit { self.unit = unit }
            if let time = log.timestamp {
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "h:mm a"
                formatter.amSymbol = "AM"
                formatter.pmSymbol = "PM"

                let dateString = formatter.string(from: time)
                print(dateString)
                
                self.timestamp = dateString
                
            }
        }
    }
}
