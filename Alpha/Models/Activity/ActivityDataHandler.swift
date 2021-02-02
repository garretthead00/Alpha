//
//  ArchiveDataHandler.swift
//  Alpha
//
//  Created by Garrett Head on 1/2/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

struct ActivityDataHandler {
    
    var id : ACTIVITY_DATA_IDENTIFIER
    var name : String
    var description : String
    var unit : Unit
    var icon : UIImage
    var data : [Date:Double]
    
    var total : Double {
        let value = data.reduce(0, {$0 + ($1.1)})
        return data.count > 0 ? value : 0.0
        
    }
    var average : Double { return data.count > 0 ? data.reduce(0, {$0 + ($1.1)}) / Double(data.count) : 0.0 }
    var count : Int { return data.count > 0 ? data.count : 0 }
    var currentValue : Double {
        let key = data.keys.sorted(by: { $0 < $1 }).first
        return data[key!] ?? 0.0
    }
    
    init(id: ACTIVITY_DATA_IDENTIFIER, name: String, description : String, icon : UIImage, data: [Date:Double], unit: Unit) {
        self.id = id
        self.name = name
        self.description = description
        self.data = data
        self.icon = icon
        self.description = description
        self.unit = unit
    }
}
