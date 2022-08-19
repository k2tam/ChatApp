//
//  OnBoardingContainerView.swift
//  ChatApp
//
//  Created by k2 tam on 12/08/2022.
//

import SwiftUI

enum OnboardingStep: Int{
    case welcome = 0
    case phoneNumber = 1
    case verification = 2
    case profile = 3
    case contacts = 4
}

struct OnBoardingContainerView: View {
    
    @Binding var isOnBoarding:Bool
    @State var currentStep:OnboardingStep = .welcome
    
    var body: some View {
        ZStack{
            Color("background")
                .ignoresSafeArea(edges: [.top, .bottom])
                
            
            switch currentStep{
                case .welcome:
                    WelcomeView(currentStep: $currentStep)
                
                case .phoneNumber:
                    PhoneNumberView(currentStep: $currentStep)
                
                case .verification:
                    VerificationView(currentStep: $currentStep, isOnboarding: $isOnBoarding)
                
                case .profile:
                    CreateProfileView(currentStep: $currentStep)
                
                case .contacts:
                    SyncContactsView(isOnBoarding: $isOnBoarding)
            }
        }
        
    }
}

struct OnBoardingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingContainerView(isOnBoarding: Binding.constant(true), currentStep: .welcome)
    }
}
