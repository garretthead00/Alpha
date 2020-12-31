//
//  AuthService.swift
//  Alpha
//
//  Created by Garrett Head on 8/19/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class AuthService {
    
    static func signIn(withEmail email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password, completion: { user, error in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        })
    }
    
    static func signUp(withEmail email: String, username: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void){
    
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            user, error in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            guard let user = user else {
                return
            }
            self.setUserInfo(withUID: user.user.uid, email: email, username: username, onSuccess: onSuccess, onError: onError)
        })
    }
    
    static func setUserInfo(withUID uid: String, email: String, username: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void){
        let ref = Database.database().reference().child("users").child(uid)
        ref.setValue(["username": username, "email": email], withCompletionBlock: {
            error, ref in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
            
        })
    }
    
}
