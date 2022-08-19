//
//  PhoneNumberView.swift
//  ChatApp
//
//  Created by k2 tam on 12/08/2022.
//

import SwiftUI
import Combine

struct PhoneNumberView: View {
    
    @Binding var currentStep: OnboardingStep
    @State var phoneNumber = ""
    
    var body: some View {
        VStack{
            Text("Verification")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Enter your mobile number below. We'll send you a verification code after")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            //Text field
            ZStack{
                Rectangle()
                    .frame(height: 56)
                    .foregroundColor(Color("input"))
                
                HStack{
                    TextField("e.g +84 1707 2184", text: $phoneNumber)
                        .font(Font.bodyParagraph)
                        .keyboardType(.phonePad)
                        .onReceive(Just(phoneNumber)) { _ in
                            TextHelper.applyPatternOnNumbers(&phoneNumber, pattern: "+## (###) ###-####", replacementCharacter: "#")
                        }
                    
                    Spacer()
                    
                    Button {
                        //Clear text field
                        phoneNumber = ""
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
                //TODO: Send phone number to Firebase Auth
                AuthViewModel.sendPhoneNumber(phone: phoneNumber) { error in
                    //Check error
                    if error == nil{
                        currentStep = .verification
                    }else{
                        //TODO: Show error
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

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView(currentStep: Binding.constant(.phoneNumber))
    }
}
