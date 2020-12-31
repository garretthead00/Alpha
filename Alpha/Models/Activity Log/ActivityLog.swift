//
//  ActivityLog.swift
//  Alpha
//
//  Created by Garrett Head on 11/24/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

protocol ActivityLog {
    var id : String? { get set }
    var uid : String? { get set }
    var sessionId : String? { get set }
    var timestamp : Date? { get set }
}
