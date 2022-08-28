//
//  ContentView.swift
//  ChatApp
//
//  Created by k2 tam on 11/08/2022.
//

import SwiftUI

struct RootView: View {
    
    //For detecting when the app state changes
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    
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
                    ChatsListView(isChatShowing: $isChatShowing)
                case .contacts:
                    ContacsListView(isChatShowing: $isChatShowing)
                }
                
                Spacer()
                
                
                CustomTabBar(selectedTab: $tabSelected)
            }
        }
        .onAppear(perform: {
            if !isOnboarding{
                //User has already onboarded, load contacts
                contactsViewModel.getLocalContacts()
                
            }
        })
        .fullScreenCover(isPresented: $isOnboarding) {
            //On Dismiss
        } content: {
            //On boarding sequence
            OnBoardingContainerView(isOnBoarding: $isOnboarding)
        }
        .fullScreenCover(isPresented: $isChatShowing, onDismiss: nil) {
            //The conversation view
            ConversationView(isChatShowing: $isChatShowing)
        }.onChange(of: scenePhase, perform: { newPhase in
            var body: some View {
                    Text("Hello, world!")
                        .padding()
                        .onChange(of: scenePhase) { newPhase in
                            if newPhase == .active {
                                print("Active")
                            } else if newPhase == .inactive {
                                print("Inactive")
                            } else if newPhase == .background {
                                chatViewModel.chatListViewCleanup()
                            }
                        }
                }
        })
        .navigationBarHidden(true)
    
    }
    
}


