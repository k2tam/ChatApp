//
//  CustomTabBar.swift
//  ChatApp
//
//  Created by k2 tam on 11/08/2022.
//

import SwiftUI


enum Tabs: Int{
    case chats = 0
    case contacts = 1
}
struct CustomTabBar: View {
    @Binding var selectedTab: Tabs
    
    var body: some View {
        
        HStack(alignment: .center){
            Button {
                //Switch tab selected to Chats
                selectedTab = Tabs.chats
            } label: {
                
                TabButton(isActive: selectedTab == .chats, buttonIcon: "bubble.left", buttonText: "Chats")

                
            }
            .tint(Color("icons-secondary"))
            
            Button {
                //TODO:
                
                AuthViewModel.logOut()
            } label: {
                VStack(alignment: .center, spacing: 4){
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        
                    Text("Chats")
                        .font(Font.tabBar)
                }
                
            }
            .tint(Color("icons-primary"))
            
            Button {
                //Switch tab selected to Contacts
                selectedTab = Tabs.contacts
            } label: {
                TabButton(isActive: selectedTab == .contacts, buttonIcon: "person", buttonText: "Contacts")
                
            }
            .tint(Color("icons-secondary"))

        }
        .frame(height: 82)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: Binding.constant(Tabs.chats))
    }
}
