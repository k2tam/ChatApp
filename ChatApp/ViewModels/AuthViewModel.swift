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
    
    static func getLoggedInUserPhone() -> String{
        return Auth.auth().currentUser?.phoneNumber ?? ""
    }
    
    static func logOut(){
        try? Auth.auth().signOut()
    }
    
    static func sendPhoneNumber(phone: String, completion: @escaping (Error?) -> Void){
        //Send the phone number to Firebase Auth
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { verificationID, error in
            if error == nil {
                //Got the verification id
                
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                            
            }
            
            
            DispatchQueue.main.async {
                //Notify the UI
                completion(error)
            }

        }
    }
    
    static func verifyCode(code: String, completion: @escaping (Error?) -> Void){
        //Get the verification id from local storage
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") ?? ""
        
        //Send the code and the verification id to Firebase
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: code
        )
        
        //Sign in the user
        Auth.auth().signIn(with: credential) { result, error in
            
            DispatchQueue.main.async {
                //Notify the UI
                completion(error)
            }
            
        }
    }
}
