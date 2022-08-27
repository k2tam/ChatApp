//
//  ConversationView.swift
//  ChatApp
//
//  Created by k2 tam on 20/08/2022.
//

import SwiftUI

struct ConversationView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @Binding var isChatShowing: Bool
    @State var chatMesage = ""
    @State var participants = [User]()
    
    var body: some View {
        
        
        VStack(spacing: 0){
            //Chat header
            HStack{
                VStack(alignment: .leading){
                    
                    //Back arrow

                    Button {
                        //Dismiss chat window
                        isChatShowing = false
                         
                    } label: {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("text-input"))
                            .frame(width: 24, height: 24)
                    }
                    .padding(.bottom, 16)

     
                    //Name
                    if participants.count > 0 {
                        
                        let participant = participants.first
                        
                        Text("\(participant?.firstName ?? "") \(participant?.lastName ?? "")")
                            .font(Font.chatHeading)
                            .foregroundColor(Color("text-header"))
                    }
                    
                }
                
                Spacer()
                
                //Profile image
                if participants.count > 0 {
                    
                    let participant = participants.first
                    
                    ProfilePicView(user: participant!)
                }
            }
            .frame(height: 104)
            .padding(.horizontal)
  
            ScrollViewReader{proxy in
                //Chat log
                ScrollView{
                    VStack(spacing: 24){
                        
                        ForEach(Array(chatViewModel.messages.enumerated()), id: \.element) {index, msg in
                            
                            let isFromUser = msg.senderid == AuthViewModel.getLoggedInUserId()
                            
                            
                            //Dynamic message
                            HStack{
                                if isFromUser{
                                    
                                    //Timestamp
                                    Text(DateHelper.chatTimeStampFrom(date: msg.timestamp))
                                        .font(Font.smallText)
                                        .foregroundColor(Color("text-timestamp"))
                                        .padding(.trailing)
                                    Spacer()
                                }
                                
                                //Message
                                Text(msg.msg)
                                    .font(Font.bodyParagraph)
                                    .foregroundColor(isFromUser ? Color("text-button") : Color("text-primary"))
                                    .padding(.vertical, 16)
                                    .padding(.horizontal, 24)
                                    .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
                                    .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
                                
                                
                                //Their message timestamp
                                if !isFromUser{
                                    
                                    Spacer()
                                    
                                    Text(DateHelper.chatTimeStampFrom(date: msg.timestamp))
                                        .font(Font.smallText)
                                        .foregroundColor(Color("text-timestamp"))
                                        .padding(.leading)
                                }
                            }
                            .id(index)
                            
                        }
                        
                    }
                    .padding(.top, 24)
                    .padding(.horizontal)
                }
                .background(Color("background"))
                .onChange(of: chatViewModel.messages.count) { newCount in
                    withAnimation {
                        proxy.scrollTo(newCount-1)

                    }
                }
            }
            
            
            //Chat message bar
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                
                HStack(spacing: 15){
                    //Camera button
                    Button {
                        //TODO: Show picker
                    } label: {
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-secondary"))
                        
                    }
       
                    //Textfield
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color("date-pill"))
                            .cornerRadius(50)
                        
                        
                        TextField("Type your message", text: $chatMesage)
                            .foregroundColor(Color("text-input"))
                            .font(Font.bodyParagraph)
                            .padding(10)
                        
                        //Emoji button
                        HStack{
                            Spacer()
                            
                            Button {
                                //Emojis
                                
                            } label: {
                                Image(systemName: "face.smiling")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Color("text-input"))
                            }
                            
                        }
                        .padding(.trailing)
                        
                        

                    }
                    .frame(height: 44)
                    
                    //Sendbutton
                    Button {
                        //TODO: Clean up text msg
                        
                        //Send message
                        chatViewModel.sendMessage(msg: chatMesage)
                        
                        //Clear textbox
                        chatMesage = ""
                        
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-primary"))
                    }
                }
                .padding(.horizontal)

            }
            .frame(height: 76)
        }
        .onAppear{
            //Call chat view model to retrieve all chat messages
            chatViewModel.getMessages()
            
            //Try to get the other participants as User instances
            let ids = chatViewModel.getParticipantIds()
            self.participants = contactsViewModel.getParticipants(ids: ids)
        }
        .onDisappear{
            
            //Do any necesary clean up before conversation view disappears
            chatViewModel.conversationViewCleanup()
        }
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(isChatShowing: .constant(false))
    }
}
