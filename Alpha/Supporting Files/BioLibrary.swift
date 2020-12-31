//
//  BioLibrary.swift
//  Alpha
//
//  Created by Garrett Head on 9/22/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

// MARK: -  General Info
let biologicalSexes : [String] = ["Male", "Female"]

// MARK: - Activity Level
let activityLevels : [String] = ["Sedentary", "Lightly", "Active", "Very"]
let activityLevelDescriptions : [String] = [
    "A sedentary or inactive lifestyle means that you get no formal exercise and are not physically active during the day. A sedentary lifestyle contributes to weight gain and eventually, obesity.",
    "Light physical activity refers to activities you do regularly as a part of your everyday life. You might also call these lifestyle activities, like taking the dog for a walk or gardening. These types of activities typically burn about 150 calories a day for the average person.",
    "A moderate exercise program refers to participating in some type of cardiorespiratory endurance exercise for at 20 to 60 minutes, three to five days per week.",
    "A vigorous exercise program refers to exercising for 20 to 60 minutes most days a week, which may include aerobic exercise, interval training, strength training, and stretching exercises."]
let activityLevelImages : [UIImage?] = [
    UIImage(named: "activityLevel_Sedentary"),
    UIImage(named: "activityLevel_Lightly"),
    UIImage(named: "activityLevel_Active"),
    UIImage(named: "activityLevel_Very")
]


// MARK: - Body Type
let bodyTypes : [String] = ["Ectomorph", "Mesomorph", "Endomorph"]
let bodyTypeDescriptions : [String] = [
    "Lean and long, with difficulty building muscle.\nEctomorphs are good at processing carbohydrates into energy and your fast metabolism means that you burn off fat easily. The downside is that you struggle to bulk up because your fast-twitch fibres are underdeveloped.",
    "Muscular and well-built, with a high metabolism and responsive muscle cells.\nYou have the body type that finds it easiest to add new muscle and you don’t tend to store much body fat. Mesomorphs tend to take their naturally athletic builds for granted, which can result in diluted workouts and poor diets.",
    "Big, high body fat, often pear-shaped, with a high tendency to store body fat.\nEndomorphs are adept at storing fuel, with muscle and fat concentrated in the lower body. The endomorph is the hardest body type to have in terms of managing your weight and overall fitness."]
let bodyTypeImages : [UIImage?] = [
    UIImage(named: "bodyType_Ectomorph"),
    UIImage(named: "bodyType_Mesomorph"),
    UIImage(named: "bodyType_Endomorph")
]
