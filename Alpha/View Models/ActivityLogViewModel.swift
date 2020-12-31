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
    var icon : UIImage?

    init(log: ActivityLog) {
        self.name = ""
        self.timestamp = ""
        self.value = 0.0
        if let log = log as? NutritionLog, let food = log.food {
            if let name = food.name { self.name = name }
            if let icon = food.category { self.icon = UIImage(named: icon) }
            if let value = log.servingSize { self.value = value }
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
