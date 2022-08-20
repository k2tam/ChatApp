//
//  ConversationView.swift
//  ChatApp
//
//  Created by k2 tam on 20/08/2022.
//

import SwiftUI

struct ConversationView: View {
    
    @Binding var isChatShowing: Bool
    @State var chatMesage = ""

    var body: some View {
        VStack{
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
                    Text("Tam Bui")
                        .font(Font.chatHeading)
                        .foregroundColor(Color("text-header"))
                    
                }
                
                Spacer()
                
                //Profile image
                ProfilePicView(user: User())
            }
            .frame(height: 104)
            .padding(.horizontal)
  
            //Chat log
            ScrollView{
                VStack(spacing: 24){
                    
                    //Their message
                    HStack{
                        
                        //Message
                        Text("Lorem ipsum dolor sit amet")
                            .font(Font.bodyParagraph)
                            .foregroundColor(Color("text-primary"))
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                            .background(Color("bubble-secondary"))
                            .cornerRadius(30, corners: [.topLeft, .topRight, .bottomRight])

                        
                        Spacer()
                        //Timestamp
                        Text("9:41")
                            .font(Font.smallText)
                            .foregroundColor(Color("text-timestamp"))
                            .padding(.leading)
                    }

                    
                    
                    
                    //Your message
                    HStack{
                        
                        
                        //Timestamp
                        Text("9:41")
                            .font(Font.smallText)
                            .foregroundColor(Color("text-timestamp"))
                            .padding(.trailing)
                        
                        Spacer()
                        
                        //Message
                        Text("Lorem ipsum dolor sit amet, consecteur adipscing elit ut aliquam")
                            .font(Font.bodyParagraph)
                            .foregroundColor(Color("text-button"))
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                            .background(Color("bubble-primary"))
                            .cornerRadius(30, corners: [.topLeft, .topRight, .bottomLeft])
                        
                        
                    }
                    
                }
                .padding(.top, 24)
                .padding(.horizontal)
            }
            .background(Color("background"))
            
            //Chat message bar
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                
                HStack{
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
                        
                        

                    }
                    .frame(height: 44)
                    
                    //Sendbutton
                    Button {
                        //TODO: Send message
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
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(isChatShowing: .constant(false))
    }
}
