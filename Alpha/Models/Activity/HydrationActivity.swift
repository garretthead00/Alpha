//
//  HydrationActivity.swift
//  Alpha
//
//  Created by Garrett Head on 11/24/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

struct HydrationActivity : Activity {
    
    // MARK: - Activity Properties
    var name: String
    var icon: UIImage
    var color: UIColor
    var progress: Double? {
        let handler = archiveDataHandlers.filter({ $0.id == progressIdentifier }).first
        return handler?.total
    }
    var healthKitIdentifiers : [String]?
    var healthKitEnabled : Bool? = false
    var activityType: ActivityType? = .hydration
    var progressIdentifier : ACTIVITY_DATA_IDENTIFIER = .Water
    var activityDataIdentifiers : [ACTIVITY_DATA_IDENTIFIER] = [.Water]
    var archiveDataHandlers : [ActivityDataHandler] = []
    
    init() {
        self.name = "Hydration"
        self.icon = UIImage(named: "Hydration")!
        self.color = .systemBlue
    }

    
    func getHandler(withIdentifier identifier: ACTIVITY_DATA_IDENTIFIER) -> ActivityDataHandler? {
        return archiveDataHandlers.filter({ $0.id == identifier }).first
    }
    func getValue(withIdentifier identifier: ACTIVITY_DATA_IDENTIFIER) -> Double {
        let handler = archiveDataHandlers.filter({ $0.id == identifier }).first
        return handler?.total ?? 0.0
    }
}
