//
//  TargetDelegate.swift
//  Alpha
//
//  Created by Garrett Head on 1/25/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import Foundation

protocol TargetDelegate {
    func updateMacros(viewModels: [ActivityTargetHandlerViewModel])
    func updateBodyGoalTarget(value: String)
}
