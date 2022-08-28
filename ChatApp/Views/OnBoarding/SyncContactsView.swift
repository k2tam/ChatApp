//
//  SyncContactsView.swift
//  ChatApp
//
//  Created by k2 tam on 12/08/2022.
//

import SwiftUI

struct SyncContactsView: View {


    @EnvironmentObject var contactsViewModel:ContactsViewModel
    
    @Binding var isOnBoarding: Bool
    
    var body: some View {
        VStack{
            Spacer()
            Image("onboarding-all-set")
            
            Text("Awesome !")
                .font(Font.titleText)
                .padding(.top, 32)
            
            Text("Continue to start chatting with your fiends")
                .font(Font.bodyParagraph)
                .padding(.top, 8)
            
            Spacer()
            
            Button {
                //Dissmiss the onboarding screen sheet
                isOnBoarding = false
                
            }label: {
                Text("Continue")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
            
            
        }
        .padding(.horizontal)
        .onAppear{
            //Get local contacts
            contactsViewModel.getLocalContacts()
        }
        
    }
}

struct SyncContactsView_Previews: PreviewProvider {
    static var previews: some View {
        SyncContactsView(isOnBoarding: Binding.constant(true))
    }
}
