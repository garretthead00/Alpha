//
//  Activity.swift
//  Alpha
//
//  Created by Garrett Head on 11/20/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

enum ActivityType {
    case fitness
    case nutrition
    case hydration
    case sleep
    case mindfulness
}

protocol Activity {
    var name : String { get }
    var icon : UIImage { get }
    var color : UIColor { get }
    var progress : Double? { get set }
    var healthKitIdentifiers : [String]? { get set }
    var healthKitEnabled : Bool? { get set }
    var activityType : ActivityType? { get set }
    mutating func setValue(forIdentifier id: String, value: Double)
    mutating func updateActivity()
    mutating func calculateTotals()
    func getValue(ofKey key: String) -> Double
}
