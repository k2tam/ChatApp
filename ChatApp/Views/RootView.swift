//
//  ContentView.swift
//  ChatApp
//
//  Created by k2 tam on 11/08/2022.
//

import SwiftUI

struct RootView: View {
    @State var tabSelected:Tabs = Tabs.contacts
    @State var isOnboarding = !AuthViewModel.isLoggedIn()
    
    @State var isChatShowing = false
    
    var body: some View {
        
        ZStack{
            Color("background")
                .ignoresSafeArea()
            
            VStack{
                
                switch tabSelected {
                    
                case .chats:
                    ChatsListView()
                case .contacts:
                    ContacsListView(isChatShowing: $isChatShowing)
                }
                
                Spacer()
                
                
                CustomTabBar(selectedTab: $tabSelected)
            }
        }
        .fullScreenCover(isPresented: $isOnboarding) {
            //On Dismiss
        } content: {
            //On boarding sequence
            OnBoardingContainerView(isOnBoarding: $isOnboarding)
        }
        .fullScreenCover(isPresented: $isChatShowing, onDismiss: nil) {
            //The conversation view
            ConversationView(isChatShowing: $isChatShowing)
        }
        .navigationBarHidden(true)
    
    }
    
}


