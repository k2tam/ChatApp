//
//  VerificationView.swift
//  ChatApp
//
//  Created by k2 tam on 12/08/2022.
//

import SwiftUI
import Combine

struct VerificationView: View {
    
    @Binding var currentStep: OnboardingStep
    @Binding var isOnboarding: Bool
    @State var verificationCode = ""
    
    var body: some View {
        VStack{
            Text("Verification")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Enter the 6-digit verification code we sent to your device")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            //Text field
            ZStack{
                Rectangle()
                    .frame(height: 56)
                    .foregroundColor(Color("input"))
                
                HStack{
                    TextField("e.g +84 1707 2184", text: $verificationCode)
                        .font(Font.bodyParagraph)
                        .keyboardType(.numberPad)
                        .onReceive(Just(verificationCode)) { _ in
                            TextHelper.limitText(&verificationCode, 6)
                        }
                    
                    Spacer()
                    
                    Button {
                        //Clear text field
                        verificationCode = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .frame(width: 19, height: 19)
                            .foregroundColor(Color("icons-input"))
                    }
     
                }
                .padding(.horizontal)
            }
                .padding(.top, 34)
            
            Spacer()
            
            Button {
                //Send the verification code to Firebase
                AuthViewModel.verifyCode(code: verificationCode) { error in
                    
                    
                    
                    if error == nil{
                        
                        //Check if this user has a profile
                        DatabaseService().checkUserProfile { exists in
                            if exists {
                                //End the onboarding
                                isOnboarding = false
                                
                            }else{
                                //Move to the profile creation step
                                currentStep = .profile
                            }
                        }
                        
                    }else{
                        //TODO: Show error message
                    }
                    
                }
            } label: {
                Text("Next")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)

        }
        .padding(.horizontal)
    }
}


struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(currentStep: Binding.constant(.verification), isOnboarding: Binding.constant(true))
    }
}
