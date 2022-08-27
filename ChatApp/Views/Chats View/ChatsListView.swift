//
//  ChatsListView.swift
//  ChatApp
//
//  Created by k2 tam on 19/08/2022.
//

import SwiftUI

struct ChatsListView: View {
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @Binding var isChatShowing: Bool
    
    var body: some View {
        
        VStack{
            //Heading
            HStack{
                Text("Chats")
                    .font(Font.pageTitle)
                Spacer()
                
                Button {
                    //TODO: Settings
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(Color("icons-secondary"))
                    
                }
            }
            .padding(.top, 20)
            .padding(.horizontal)
            //Chat List
            
            if chatViewModel.chats.count > 0{
                List(chatViewModel.chats){chat in
                    
                    Button {
                        //Set selected chat for the chatviewmodel
                        chatViewModel.selectedChat = chat
                        
                        //Display converstion view
                        isChatShowing = true
                        
                        
                    } label: {
                        ChatsListRow(chat: chat, otherParticipants: contactsViewModel.getParticipants(ids: chat.participantids))

                    }
                    .buttonStyle(.plain)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)

                }
                .listStyle(.plain)
            }
            else{
                
                Spacer()
                Image("no-chats-yet")
                
                Text("Hmm... there’s no chats here")
                    .font(Font.titleText)
                    .padding(.top, 32)
                
                Text("Let's text someone")
                    .font(Font.bodyParagraph)
                    .padding(.top, 8)
                
                Spacer()
            }
        }
        
        
        
    }
}

struct ChatsListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsListView(isChatShowing: Binding.constant(false))
    }
}
