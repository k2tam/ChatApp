//
//  ChatsListRow.swift
//  ChatApp
//
//  Created by k2 tam on 27/08/2022.
//

import SwiftUI

struct ChatsListRow: View {
    
    var chat: Chat
    
    var otherParticipants: [User]?
    
    var body: some View {
        
        HStack(spacing: 24){
            
            //Assume at least 1 other participants in the chat
            let participant = otherParticipants!.first
            
            //Profile image of participants
            if otherParticipants != nil && otherParticipants!.count == 1 {
                //Display profile image of single participant
                if participant != nil{
                    ProfilePicView(user: participant!)
                }
            }
            else if otherParticipants != nil && otherParticipants!.count > 1 {
                //Display group profile fimage
                GroupProfilePicView(users: otherParticipants!)
            }
            
            
            
            VStack(alignment: .leading, spacing: 4){
                //Name
                if let otherParticipants = otherParticipants {
                    
                    Group{
                        if otherParticipants.count == 1{
                            
                            Text("\(participant!.firstName ?? "") \(participant!.lastName ?? "")")
                        
                        }
                        else if otherParticipants.count == 2{
                            
                            let participant2 = otherParticipants[1]
                            
                            Text("\(participant!.firstName ?? ""),\(participant2.firstName ?? "")")
                              
                        }
                        else if otherParticipants.count > 2{
                            let participant2 = otherParticipants[1]
                            
                            Text("\(participant!.firstName ?? ""), \(participant2.firstName ?? "") + \(otherParticipants.count-2) others")
                                
                        }
                    }
                    .font(Font.button)
                    .foregroundColor(Color("text-primary"))
                    
                    
                }
   
                
                //Last message
                Text(chat.lastmsg ?? "")
                    .font(Font.bodyParagraph)
                    .foregroundColor(Color("text-input"))
                
            }
            
            //Extra space
            Spacer()
            
            //Timestamp
            Text(chat.updated == nil ? "" : DateHelper.chatTimeStampFrom(date: chat.updated!))
                .font(Font.bodyParagraph)
                .foregroundColor(Color("text-input"))
        }
    }
}


