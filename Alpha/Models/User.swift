//
//  User.swift
//  Alpha
//
//  Created by Garrett Head on 8/20/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation

class User {

    var uid: String?
    var username : String?
    var email: String?
    var profileImageUrl : String?
    
    
}

extension User {
    static func transformUser(data: [String: Any], key: String) -> User {
        let user = User()
        user.uid = key
        user.username =  data["username"] as? String
        user.email = data["email"] as? String
        user.profileImageUrl = data["profileImage"] as? String
        return user
    }
    

}
