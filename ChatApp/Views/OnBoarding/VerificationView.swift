//
//  VerificationView.swift
//  ChatApp
//
//  Created by k2 tam on 12/08/2022.
//

import SwiftUI

struct VerificationView: View {
    
    @Binding var currentStep: OnboardingStep
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
                //Go to create profile view
                currentStep = .profile
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
        VerificationView(currentStep: Binding.constant(.verification))
    }
}
