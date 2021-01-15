//
//  ActivityFactory.swift
//  Alpha
//
//  Created by Garrett Head on 1/13/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import Foundation

struct ActivityFactory {
    
    func createActivity(_ type: ActivityType) -> Activity {
        let activity : Activity
        switch type {
            case .fitness: activity = FitnessActivity()
            case .nutrition: activity = NutritionActivity()
            case .hydration: activity = HydrationActivity()
            case .sleep: activity = SleepActivity()
            case .mindfulness: activity = MindfulnessActivity()
        }
        return activity
    }
    
}
