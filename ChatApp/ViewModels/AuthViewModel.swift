//
//  AuthViewModel.swift
//  ChatApp
//
//  Created by k2 tam on 11/08/2022.
//

import Foundation
import FirebaseAuth

class AuthViewModel{
    
    static func isLoggedIn() -> Bool{
        return Auth.auth().currentUser != nil
    }
    
    static func getLoggedInUserId() -> String{
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    static func logOut(){
        try? Auth.auth().signOut()
    }
}
