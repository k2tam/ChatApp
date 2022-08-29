//
//  ContactsPicker.swift
//  ChatApp
//
//  Created by k2 tam on 29/08/2022.
//

import SwiftUI

struct ContactsPicker: View {
    @Binding var isContactsPickerShowing: Bool
    @Binding var selectedContacts: [User]
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    var body: some View {
        ZStack{
            Color("background")
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                ScrollView{
                    ForEach(contactsViewModel.filteredUsers) { user in
                        
                        //Determine if this user is a selectedContact
                        let isSelectedContact = selectedContacts.contains { u in
                            u.id == user.id
                        }
                        ZStack{
                            ContactRow(user: user)
                                .padding(.top, 18)
                            
                            HStack{
                                Spacer()
        
                                Button {
                                    //Toggle the user to be selected or not
                                    if isSelectedContact{
                                        //Remove this contact from the selected pool
                                        selectedContacts.removeAll()
                                    }else{
                                        //Remove the other contacts first
                                        selectedContacts.removeAll()
                                        
                                        //Select this contact
                                        selectedContacts.append(user)
                                        
                                    }

                                    
                                } label: {
                                    Image(systemName: isSelectedContact ? "checkmark.circle.fill" : "checkmark.circle")
                                        .resizable()
                                        .foregroundColor(Color("button-primary"))
                                        .frame(width: 25, height: 25)
                                }

                            }
                            .padding(.horizontal)

                        }
                        
                    
                    }
                }
                
                Button {
                    //Done. Dismiss the contact picker
                    isContactsPickerShowing = false
                } label: {
                    ZStack{
                        Color("button-primary")
                        
                        Text("Done")
                            .font(Font.button)
                            .foregroundColor(Color("text-button"))
                    }
                }
                .frame(height: 56)

            }
        }
        .onAppear{
            contactsViewModel.filterContacts(filterBy: "")
        }
    }
}




