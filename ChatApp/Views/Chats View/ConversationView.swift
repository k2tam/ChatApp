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
    
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    
    @State var isContactsPickerShowing = false
    
    @State var isSourceMenuShowing = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        
        ZStack{
            Color("background")
                .ignoresSafeArea()
        
            VStack(spacing: 0){
            //Chat header
            ZStack{
                Color(.white)
                    .ignoresSafeArea()
                
                HStack{
                    VStack(alignment: .leading){
                        
                        HStack{
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
                            
                            //Label for new message
                            if participants.count == 0{
                                Text("New Message")
                                    .font(Font.chatHeading)
                                    .foregroundColor(Color("text-header"))
                            }
                        }
                        .padding(.bottom, 16)
                        
                        
                        //Name
                        if participants.count > 0 {
                            
                            let participant = participants.first
                            
                            Text("\(participant?.firstName ?? "") \(participant?.lastName ?? "")")
                                .font(Font.chatHeading)
                                .foregroundColor(Color("text-header"))
                        }
                        else{
                            //New message
                            Text("Recipient")
                                .font(Font.bodyParagraph)
                                .foregroundColor(Color("text-input"))
                        }
                        
                    }
                    
                    Spacer()
                    
                    //Profile image
                    if participants.count > 0 {
                        
                        let participant = participants.first
                        
                        ProfilePicView(user: participant!)
                    }
                    else{
                        //New message
                        Button {
                            //Show contact picker
                            isContactsPickerShowing = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .foregroundColor(Color("button-primary"))
                                .frame(width: 25, height: 25)
                        }
                        
                    }
                }
                .frame(height: 104)
                .padding(.horizontal)
            }
            .frame(height: 104)
            
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
                                
                                if msg.imageurl != ""{
                                    //Photo message
                                    
                                    ConversationPhotoMessage(imageUrl: msg.imageurl!, isFromUser: isFromUser)
                                    
                                }
                                else{
                                    //TextMessage
                                    ConversationTextMessage(msg: msg.msg, isFromUser: isFromUser)
                                }
                                
                                
                                
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
                .onChange(of: chatViewModel.messages.count) { newCount in
                    withAnimation {
                        proxy.scrollTo(newCount-1)
                        
                    }
                }
            }
            
            
            //Chat message bar
            ZStack{
                
                HStack(spacing: 15){
                    //Camera button
                    Button {
                        //Show picker
                        isSourceMenuShowing = true
                        
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
                        
                        if selectedImage != nil{
                            //Display image in message bar
                            Text("Image")
                                .foregroundColor(Color("text-input"))
                                .font(Font.bodyParagraph)
                                .padding(10)
                            
                            //Delete button
                            HStack{
                                Spacer()
                                
                                Button {
                                    //Delete the image
                                    selectedImage = nil
                                    
                                    
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Color("text-input"))
                                }
                                
                            }
                            .padding(.trailing)
                            
                        }
                        else{
                            TextField("Type your message", text: $chatMesage)
                                .foregroundColor(Color("text-input"))
                                .font(Font.bodyParagraph)
                                .padding(10)
                        }
                        
                        
                    }
                    .frame(height: 44)
                    
                    //Sendbutton
                    Button {
                        
                        //Check if image is selected, if so send image
                        
                        if selectedImage != nil{
                            //Send image message
                            chatViewModel.sendPhotoMesaage(image: selectedImage!)
                            
                            //Clear image
                            selectedImage = nil
                            
                        }
                        else{
                            //Clean up text msg
                            chatMesage = chatMesage.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            //Send message
                            chatViewModel.sendMessage(msg: chatMesage)
                            
                            //Clear textbox
                            chatMesage = ""
                        }
                        
                        
                        
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-primary"))
                    }
                    .disabled(chatMesage.trimmingCharacters(in: .whitespacesAndNewlines) == "" && selectedImage == nil)
                    
                }
                .disabled(participants.count == 0)
                .padding(.horizontal)
                .frame(height: 76)
            }
            
        }

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
        .confirmationDialog("From where ?", isPresented: $isSourceMenuShowing, actions: {
            
            Button {
                //Set source to photo library
                self.source = .photoLibrary
                
                //Show image picker
                isPickerShowing = true
            } label: {
                Text("Photo Library")
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                Button {
                    //Set source to photo library
                    self.source = .camera
                    
                    //Show image picker
                    isPickerShowing = true
                } label: {
                    Text("Take camera")
                }
            }
            
    
        })
        .sheet(isPresented: $isPickerShowing) {
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, source: source)
        }.sheet(isPresented: $isContactsPickerShowing) {
            //When sheet is dismissed
            
            //Search for the conversation with selected participant
            if let participant = participants.first{
                chatViewModel.getChatFor(contact: participant)
            }
            
        } content: {
            ContactsPicker(isContactsPickerShowing: $isContactsPickerShowing, selectedContacts: $participants)
        }

    
}
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(isChatShowing: .constant(false))
    }
}
