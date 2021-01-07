//
//  HydrationTargetViewModel.swift
//  Alpha
//
//  Created by Garrett Head on 12/31/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

class HydrationTargetViewModel {
    
    var waterDrank : Double
    var targetValue : Double
    var unit : String
    
    init(waterDrank: Double, target: UserTarget) {
        self.waterDrank = waterDrank
        self.targetValue = target.value!
        self.unit = target.unit ?? ""
    }
    
}
