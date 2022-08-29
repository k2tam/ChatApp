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
        
        
        
        ZStack {
            
            // Check if user has a photo set
            if user.photo == nil {
                
                // Display circle with first letter of first name
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                    
                    Text(user.firstName?.prefix(1) ?? "")
                        .bold()
                }
                
            }
            else {
                
                // Check image cache, if it exists, use that
                if let cachedImage = CacheService.getImage(forKey: user.photo!) {
                    
                    // Image is in cache so lets use it
                    cachedImage
                        .resizable()
                        .clipShape(Circle())
                        .scaledToFill()
                        .clipped()
                }
                else {
                    
                    // If not in cache, download it
                    
                    // Create URL from user photo url
                    let photoUrl = URL(string: user.photo ?? "")
                    
                    // Profile image
                    AsyncImage(url: photoUrl) { phase in
                        
                        switch phase {
                            
                        case .empty:
                            // Currently fetching
                            ProgressView()
                            
                        case .success(let image):
                            // Display the fetched image
                            image
                                .resizable()
                                .clipShape(Circle())
                                .scaledToFill()
                                .clipped()
                                .onAppear {
                                    // Save this image into cache
                                    CacheService.setImage(image: image,
                                                          forKey: user.photo!)
                                }
                            
                        case .failure:
                            // Couldn't fetch profile photo
                            // Display circle with first letter of first name
                            
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                
                                Text(user.firstName?.prefix(1) ?? "")
                                    .bold()
                            }
                        }
                        
                    }
                }
                
                
                
            }
            
            // Blue border
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
