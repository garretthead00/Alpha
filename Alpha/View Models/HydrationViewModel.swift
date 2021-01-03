//
//  HydrationViewModel.swift
//  Alpha
//
//  Created by Garrett Head on 12/17/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

class HydrationViewModel {
    
    var progress : Double
    var target : Double
    var remaining : Double {
        let value = target - progress
        return value > 0.0 ? value : 0.0
    }
    var percentProgress : Double {
        return target > 0 ? progress / target * 100 : 0.0
    }
    var unit : String?
    
    
    init(activity: HydrationActivity, target: UserTarget){
        self.progress = activity.progress ?? 0.0
        self.target = target.value as! Double
        self.unit = target.unit
    }
}
