//
//  ContactsViewModel.swift
//  ChatApp
//
//  Created by k2 tam on 13/08/2022.
//

import Foundation
import Contacts

class ContactsViewModel: ObservableObject{
    
    private var users = [User]()
    private var filterText = ""
    @Published var filteredUsers = [User]()
    
    private var localContacts = [CNContact]()
    
    
    //Perform contact store method asynchronously so it wont block the UI
    func getLocalContacts(){
        
        DispatchQueue.init(label: "getContacts") .async {
            //Ask for permission
            let store = CNContactStore()
            
            
            //List of keys to fetch
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
            
            //Create contact fetch request
            let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
            
            
            
            do{
                //Get the contacts on user's phone
                try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, success in
                    //Do something
                    self.localContacts .append(contact)
                    
                })
            }catch{
                //Handle error
            }
            
            //See with local contacts are currently users of this app
            DatabaseService().getPlatformUsers(localContacts: self.localContacts) { platformUsers in
                
                //Update the UI in main thread
                DispatchQueue.main.async {
                    //Set the fetched users to the published users property
                    self.users = platformUsers
                    
                    //Set the filtered list
                    self.filterContacts(filterBy: self.filterText)
                }
                
            }
        }
        
        
    }
    
    func filterContacts(filterBy: String){
        
        
        //Store parameter into property
        self.filterText = filterBy
        
        //If filter text is empty then reveal all user
        if filterText == "" {
            self.filteredUsers = users
            return
        }
        
        //Run the users list through the filter term to get a list of filtered users
        self.filteredUsers = users.filter({ user in
            //Criteria for including this user info into filtered list
            user.firstName?.lowercased().contains(filterText) ?? false ||
            user.lastName?.lowercased().contains(filterText) ?? false ||
            user.phone?.lowercased().contains(filterText) ?? false
        })
    }
}
