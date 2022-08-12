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
    
    var body: some View {
        
        VStack{
            Text("Hello, world!")
                .padding()
            
            Spacer()
            
            
            CustomTabBar(selectedTab: $tabSelected)
        }
        .fullScreenCover(isPresented: $isOnboarding) {
            //On Dismiss
        } content: {
            //On boarding sequence
            OnBoardingContainerView(isOnBoarding: $isOnboarding)
        }

       
    }
    
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
