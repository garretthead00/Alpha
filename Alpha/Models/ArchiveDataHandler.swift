//
//  ArchiveDataHandler.swift
//  Alpha
//
//  Created by Garrett Head on 1/2/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import Foundation

struct ArchiveDataHandler {
    
    var id : ACTIVITY_DATA_IDENTIFIER
    var unit : String
    var data : [Date:Double]
    
    var total : Double { return data.count > 0 ? data.reduce(0, {$0 + ($1.1)})  : 0.0 }
    var average : Double { return data.count > 0 ? data.reduce(0, {$0 + ($1.1)}) / Double(data.count) : 0.0 }
    var count : Int { return data.count > 0 ? data.count : 0 }
    var currentValue : Double {
        let key = data.keys.sorted(by: { $0 < $1 }).first
        return data[key!] ?? 0.0
    }

    init(identifier: ACTIVITY_DATA_IDENTIFIER, data: [Date:Double]){
        self.id = identifier
        self.unit = ""
        self.data = data
    }
}
