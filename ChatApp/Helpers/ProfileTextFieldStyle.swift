//
//  ProfileTextFieldStyle.swift
//  ChatApp
//
//  Created by k2 tam on 12/08/2022.
//

import Foundation
import SwiftUI

struct ProfileTextFieldStyle: TextFieldStyle{
    func _body(configuration: TextField<Self._Label>) -> some View{
        ZStack{
            Rectangle()
                .foregroundColor(Color("input"))
                .frame(height: 46)
                .cornerRadius(8)
            
            //Reference the textfield
            configuration
                .font(Font.tabBar)
        }
    }
}
