//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by k2 tam on 21/08/2022.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject{
    
    @Published var chats = [Chat]()
    
    @Published var selectedChat: Chat?
    @Published var messages = [ChatMessage]()
    
    var databaseServiece = DatabaseService()
    
    init(){
        //Retrieve chats when ChatViewModel is created
        getChats()
    }
    
    func clearSelectedChat(){
        self.selectedChat = nil
        self.messages.removeAll()
    }
    
    func getChats(){
        //Use the database service to retrieve the chats
        databaseServiece.getAllChats { chats in
            //Set the retrieved data to the chats property
            self.chats = chats
        }
    }
    
    func getMessages(){
        //Check that there's a selected chat
        guard selectedChat != nil else{
            return
        }
        
        //Use the database service to retrieve the messages
        databaseServiece.getAllMessages(chat: selectedChat!) { msgs in
            //Set returned messages to a property
            
            self.messages = msgs
            
        }
    }
    
    ///Search for chat with passed in user. If found, set as selected chat. If not found, create a new chat
    func getChatFor(contacts: [User]){
        
        //Check the user
        for contact in contacts{
            if contact.id == nil {return }
        }
        
        //Create a set from the ids of the contacts passed in
        let setOfContactIds = Set(arrayLiteral: contacts.map { u in u.id!})
        
        let foundChat = chats.filter { chat in
            
            let setOfParticipantIds = Set(arrayLiteral: chat.participantids)
            
            return chat.numparticipants == contacts.count+1 && setOfContactIds.isSubset(of: setOfParticipantIds)
            // Another way
//            switch contacts.count {
//                case 1:
//                    return chat.numparticipants == contacts.count + 1 && chat.participantids.contains(contacts[0].id!)
//                case 2:
//                    return chat.numparticipants == contacts.count + 1 && chat.participantids.contains(contacts[0].id!) && chat.participantids.contains(contacts[1].id!)
//                case 3: return chat.numparticipants == contacts.count + 1 && chat.participantids.contains(contacts[0].id!) && chat.participantids.contains(contacts[1].id!) && chat.participantids.contains(contacts[2].id!)
//
//                default:
//                return false
//            }
        }
        
        if !foundChat.isEmpty{
            
            //Set as selected chat
            self.selectedChat = foundChat.first!
            
            //Fetch the messages
            getMessages()
            
        }else{
            //No chat was found, create a new one
            
            //Create array of ids of all participants
            var allParticipantIds = contacts.map { u in u.id!}
            allParticipantIds.append(AuthViewModel.getLoggedInUserId())
            
            var newChat = Chat(id: nil,
                               numparticipants: allParticipantIds.count,
                               participantids: allParticipantIds,
                               lastmsg: nil,
                               updated: nil,
                               msgs: nil)
            
            //Set as selected chat
            self.selectedChat = newChat
            
            //Save new chat to the database
            databaseServiece.createChat(chat: newChat) { docId in
                
                //Set doc id from the auto generated document in the database
                self.selectedChat = Chat(id: docId, numparticipants: 2, participantids: allParticipantIds, lastmsg: nil, updated: nil, msgs: nil)
                
                //Add chat to the chat list
                self.chats.append(self.selectedChat!)
            }
            
          
        }
    }
    
    func sendMessage(msg: String){
        //Check that we have selected chat
        guard selectedChat != nil else{
            return
        }
        
        databaseServiece.sendMessage(msg: msg, chat: selectedChat!)
    }
    
    func sendPhotoMesaage(image: UIImage){
        //Check that we have selected chat
        guard selectedChat != nil else{
            return
        }
        
        databaseServiece.sendPhotoMessage(image: image,chat: selectedChat!)
    }
    
    //MARK: - Helper methods

    
    ///Tasks in a list of user ids, removes the user from that list and returns the remaining ids
    func getParticipantIds() -> [String]{
        //Check that we have a selected chat
        guard selectedChat != nil else{
            return [String]()
        }

        //Filter out the user id
        let ids = selectedChat!.participantids.filter { id in
            id != AuthViewModel.getLoggedInUserId()
        }
        
        return ids
    }
    
    func conversationViewCleanup(){
        databaseServiece.detachConversationViewListeners()
    }
    
    func chatListViewCleanup(){
        databaseServiece.detachChatListViewListeners()
    }
}
