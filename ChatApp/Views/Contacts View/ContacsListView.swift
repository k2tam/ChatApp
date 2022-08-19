//
//  ContacsListView.swift
//  ChatApp
//
//  Created by k2 tam on 19/08/2022.
//

import SwiftUI

struct ContacsListView: View {
    
    @EnvironmentObject var contactViewModel: ContactsViewModel
    @State var filterText = ""
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Contacts")
                    .font(Font.pageTitle)
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(Color("icons-secondary"))
                    
                }
                
            }
            .padding(.top, 20)
            //Search bar
            ZStack{
                Rectangle()
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                
                
                TextField("Search contact or number", text: $filterText)
                    .font(Font.tabBar)
                    .foregroundColor(Color("text-textfield"))
                    .padding()
                
            }
            .frame(height: 46)
            .onChange(of: filterText) {value in
                //Filter the results
                contactViewModel.filterContacts(filterBy: filterText)
            }
            
            if contactViewModel.filteredUsers.count > 0{
                //List
                List(contactViewModel.filteredUsers){ user in
                    //TODO: Display rows
                    ContactRow(user: user)
                }
                .listStyle(.plain)
            }else{
                Spacer()
                Image("no-contacts-yet")
                
                Text("Hmm... there’s no contatcts here")
                    .font(Font.titleText)
                    .padding(.top, 32)
                
                Text("Add your friends now")
                    .font(Font.bodyParagraph)
                    .padding(.top, 8)
                
                Spacer()
            }
            
            
        }
        .padding(.horizontal)
        .onAppear {
            contactViewModel.getLocalContacts()
        }
        
    }
}

struct ContacsListView_Previews: PreviewProvider {
    static var previews: some View {
        ContacsListView()
    }
}
