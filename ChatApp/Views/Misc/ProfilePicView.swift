//
//  ProfilePicView.swift
//  ChatApp
//
//  Created by k2 tam on 20/08/2022.
//

import SwiftUI

struct ProfilePicView: View {
    
    var user: User
    
    var body: some View {
        ZStack{
            //Check if user has a photo set
            if user.photo == nil{
                //Blue border
                Circle()
                    .stroke(Color("create-profile-border"), lineWidth: 2)
            }else{
                //Create URL from user photo url
                let photoUrl = URL(string: user.photo ?? "")
                
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
            }
            
            
            
            
            //Blue border
            Circle()
                .stroke(Color("create-profile-border"), lineWidth: 2)
        }
        .frame(width: 44, height: 44)
    }
}

struct ProfilePicView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicView(user: User())
    }
}
