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
            ZStack{
                
                
                //Profile image
                AsyncImage(url: photoUrl) { phase in
                    switch phase{
                    case AsyncImagePhase.empty:
                        //Currently fetching
                        ProgressView()
                        
                    case AsyncImagePhase.success(let image):
                        //Display the fetched image
                        image
                            .resizable()
                            .scaledToFill()
                    case AsyncImagePhase.failure(let error):
                        //Couldn't fetch profile photo
                        //Display circle with first letter of first name
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                            
                            Text(user.firstName?.prefix(1) ?? "")
                                .bold()
                        }
                    }
                    
                }
                                
                
                //Blue border
                Circle()
                    .stroke(Color("create-profile-border"), lineWidth: 2)
            }
            .frame(width: 44, height: 44)

            
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
