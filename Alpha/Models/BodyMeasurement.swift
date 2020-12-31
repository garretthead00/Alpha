//
//  BioLog.swift
//  Alpha
//
//  Created by Garrett Head on 9/13/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

class BodyMeasurement {
    var id : String?
    var date : Double?
    var value : Double?
}

extension BodyMeasurement {
    static func transformBodyMeasurement(data: [String: Any], key: String) -> BodyMeasurement {
        let log = BodyMeasurement()
        log.id = key
        log.date = data["date"] as? Double
        log.value = data["value"] as? Double
        return log
    }
}
