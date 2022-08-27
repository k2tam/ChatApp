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
            if participant != nil{
                ProfilePicView(user: participant!)

            }
            
            
        
            
            VStack(alignment: .leading, spacing: 4){
                //Name
                Text(participant == nil ? "Unknown" :
                        "\(participant!.firstName ?? "") \(participant!.lastName ?? "")")
                    .font(Font.button)
                    .foregroundColor(Color("text-primary"))
                
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


