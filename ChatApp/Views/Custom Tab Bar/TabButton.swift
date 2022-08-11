//
//  TabButton.swift
//  ChatApp
//
//  Created by k2 tam on 11/08/2022.
//

import SwiftUI

struct TabButton: View {
    var isActive: Bool
    var buttonIcon: String
    var buttonText: String
    
    var body: some View {
        GeometryReader{geo in
            if isActive{
                Rectangle()
                    .tint(Color("icons-primary"))
                    .frame(width: geo.size.width/2, height: 4)
                    .padding(.leading, geo.size.width/4)
            }
            
            VStack(alignment: .center, spacing: 4){
                Image(systemName: buttonIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    
                Text(buttonText)
                    .font(Font.tabBar)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        TabButton(isActive: true, buttonIcon: "bubble.left", buttonText: "Chats")
    }
}
