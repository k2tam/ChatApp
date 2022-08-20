//
//  ContactRow.swift
//  ChatApp
//
//  Created by k2 tam on 19/08/2022.
//

import SwiftUI

struct ContactRow: View {
    var user: User
    var body: some View {
        
        HStack(spacing: 24){
            //Create URL from user photo url
            let photoUrl = URL(string: user.photo ?? "")
            
            //Profile image
           ProfilePicView(user: user)
            
            
            VStack(alignment: .leading, spacing: 4){
                //Name
                Text("\(user.firstName ?? "") \(user.lastName ?? "")")
                    .font(Font.button)
                    .foregroundColor(Color("text-primary"))
                
                //Phone Number
                Text(user.phone ?? "")
                    .font(Font.bodyParagraph)
                    .foregroundColor(Color("text-input"))
                
            }
            
            //Extra space
            Spacer()
        }
    }
}

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow(user: User())
    }
}
