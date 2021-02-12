//
//  MacroRatioChartViewModel.swift
//  Alpha
//
//  Created by Garrett Head on 2/7/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import Foundation

struct MacroRatioChartViewModel {
    
    var protein : Double
    var proteinTarget : Double
    var proteinRemaining : Double
    var proteinPercent : Double
    
    var fat : Double
    var fatTarget : Double
    var fatRemaining : Double
    var fatPercent : Double
    
    var carohydrate : Double
    var carohydrateTarget : Double
    var carohydrateRemaining : Double
    var carbohydratePercent : Double
    
    init(protein: (handler: ActivityDataHandler, target:UserTarget), fat: (handler: ActivityDataHandler, target:UserTarget),carbs: (handler: ActivityDataHandler, target:UserTarget)){
        self.protein = protein.handler.total
        self.proteinTarget = protein.target.value!
        let proteinRemaining = protein.target.value! - protein.handler.total
        self.proteinRemaining = proteinRemaining > 0.0 ? proteinRemaining : 0.0
        self.proteinPercent = protein.target.value! > 0.0 ? protein.handler.total / protein.target.value! * 100 : 0.0
        
        self.fat = fat.handler.total
        self.fatTarget = fat.target.value!
        let fatRemaining = fat.target.value! - fat.handler.total
        self.fatRemaining = fatRemaining > 0.0 ? fatRemaining : 0.0
        self.fatPercent = fat.target.value! > 0.0 ? fat.handler.total / fat.target.value! * 100 : 0.0
        
        self.carohydrate = carbs.handler.total
        self.carohydrateTarget = carbs.target.value!
        let carohydrateRemaining = carbs.target.value! - carbs.handler.total
        self.carohydrateRemaining = carohydrateRemaining > 0.0 ? carohydrateRemaining : 0.0
        self.carbohydratePercent = carbs.target.value! > 0.0 ? carbs.handler.total / carbs.target.value! * 100 : 0.0
        
    }
    
}
