//
//  DatabaseService.swift
//  ChatApp
//
//  Created by k2 tam on 13/08/2022.
//

import Foundation
import Contacts
import UIKit
import Firebase
import FirebaseStorage

class DatabaseService{
    
    func getPlatformUsers(localContacts: [CNContact], completion: @escaping ([User]) -> Void){
        
        var patformUsers = [User]()
        
        
        //Construct an array of string phone number to look up
        var lookupPhoneNumbers = localContacts.map { contact in
            
            //Turn the contact in a phone number as a string
            return TextHelper.sanitizePhoneNumber(phone: contact.phoneNumbers.first?.value.stringValue ?? "")
            
            
        }
        
        //Make sure there are lookup numbers
        guard lookupPhoneNumbers.count > 0 else{
            
            //Callback
            completion(patformUsers)
            return
        }

        //Query the database for these phone numbers
        let db = Firestore.firestore()
        
       
        while !lookupPhoneNumbers.isEmpty{
            
            //Get the first < 10 phone numbers to look up
            let tenPhoneNumbers  = Array(lookupPhoneNumbers.prefix(10))
            
            //Remove the < 10 that we're looking up
            lookupPhoneNumbers = Array(lookupPhoneNumbers.dropFirst(10))
            
            
            //Look up the first 10
            let query = db.collection("users").whereField("phone", in: tenPhoneNumbers)
            
            //Retrieve the users that are on the platform
            query.getDocuments { querySnap, error in
                //Check the error
                if error == nil && querySnap != nil{
                    //For each do that was fetched, create a user
                    for doc in querySnap!.documents{
                        if let user = try? doc.data(as: User.self){
                            //Append to the platforms user array
                            patformUsers.append(user)
                        }
                    }
                }
                
                //Check if have anymore phone numbers to lookup
                //If not we can call the completion block
                
                if lookupPhoneNumbers.isEmpty{
                    completion(patformUsers)
                }
            }
        }
        
        
        
        
        //Return those users
        completion(patformUsers)
        
    }
    
    func setUserProfile(firstName: String, lastName: String, image: UIImage?, completion: @escaping (Bool) -> Void){
        
        //Ensure that the user is logged in
        guard AuthViewModel.isLoggedIn() != false else{
            // User is not logged in
            return
        }
        
        
        //Get reference to Firestore
        let db = Firestore.firestore()

        //Set the profile data
        let doc = db.collection("users").document(AuthViewModel.getLoggedInUserId())
        
        
        doc.setData(["firstName": firstName,
                     "lastName" : lastName,
                     "phone"    : TextHelper.sanitizePhoneNumber(phone: AuthViewModel.getLoggedInUserPhone())])
        
        //Check if image is passed through
        if let image = image{
            
            // Create storage reference
            let storageRef = Storage.storage().reference()
            
            // Turn our image into data
            let imageData = image.jpegData(compressionQuality: 0.8)
            
            // Check that we were able to convert it to data
            guard imageData != nil else {
                return
            }
            
            // Specify the file path and name
            let path = "images/\(UUID().uuidString).jpg"
            let fileRef = storageRef.child(path)
            
            let uploadTask = fileRef.putData(imageData!) { meta,error in
                if error == nil && meta != nil{
                    //Get full url to image
                    fileRef.downloadURL { url, error in
                        //Check for errors
                        if url != nil && error == nil{
                            //Set that image path to the profile
                            doc.setData(["photo": url?.absoluteString], merge: true) { error in
                                
                                if error == nil {
                                    //Sucess, notify caller
                                    completion(true)
                                }
                            }
                        }else{
                            //Wasn't successful in getting download url for photo
                            completion(false)
                        }
                    }

                }else{
                    //Upload wasn't sucessful, notify caller
                    completion(false)
                }
            }
            
            
        }
        else{
            //No image was set
            completion(true)
        }
        
        

    }
    
    func checkUserProfile(completion: @escaping (Bool) -> Void){
        //Check that the user is logged
        
        guard AuthViewModel.isLoggedIn() != false else{
            return
        }
        
        //Create firebase ref
        let db = Firestore.firestore()
        
        db.collection("users").document(AuthViewModel.getLoggedInUserId()).getDocument { snapshot, error in
            
            
            //TODO: Keep the users profile data
            
            if snapshot != nil && error == nil{
                
                //Notfity that profile extists
                completion(snapshot!.exists)
            }
            else{
                //TODO: Look into using Result type to indicate failure vs profile exists
                completion(false)
            }
            
        }
    }
}
