//
//  CreateProfileView.swift
//  ChatApp
//
//  Created by k2 tam on 12/08/2022.
//

import SwiftUI

struct CreateProfileView: View {
    
    @Binding var currentStep: OnboardingStep
    @State var firstName:String = ""
    @State var lastName:String = ""
    
    var body: some View {
        VStack{
            Text("Setup Your Profile")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Just a few more details to get started")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            Spacer()
            //Image profile button
            ZStack{
                Circle()
                    .foregroundColor(.white)
                
                Circle()
                    .stroke(Color("create-profile-border"), lineWidth: 2)
                
                Image(systemName: "camera.fill")
                    .foregroundColor(Color("icons-input"))
                
            }
            .frame(width: 134, height: 134)
            
            Spacer()
            
            //First name
            TextField("Given Name", text: $firstName)
                .textFieldStyle(ProfileTextFieldStyle())
            
            //Last name
            TextField("Last Name", text: $lastName)
                .textFieldStyle(ProfileTextFieldStyle())
            
            Spacer()
            
            Button {
                //Go to create profile view
                currentStep = .contacts
            } label: {
                Text("Next")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)

        }
        .padding(.horizontal)
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(currentStep: Binding.constant(.contacts))
    }
}
