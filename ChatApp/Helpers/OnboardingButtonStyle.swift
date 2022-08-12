//
//  OnboardingButtonStyle.swift
//  ChatApp
//
//  Created by k2 tam on 12/08/2022.
//

import Foundation
import SwiftUI

struct OnboardingButtonStyle: ButtonStyle{
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            Rectangle()
                .frame(height: 50)
                .cornerRadius(4)
                .foregroundColor(Color("button-primary"))
            
            configuration.label
                .foregroundColor(Color("text-button"))
                .font(Font.button)
        }
        
    }
}
