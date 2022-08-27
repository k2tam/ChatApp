//
//  Chat.swift
//  ChatApp
//
//  Created by k2 tam on 20/08/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Chat: Codable, Identifiable{
    @DocumentID var id: String?
    
    var numparticipants: Int
    
    var participantids: [String]
        
    var lastmsg: String?
    
    @ServerTimestamp var updated: Date?
    
    var msgs: [ChatMessage]?
}

struct ChatMessage: Codable, Identifiable, Hashable{
    @DocumentID var id: String?
    
    var imageurl: String?
    
    var msg: String
    
    var senderid: String
    
    @ServerTimestamp var timestamp: Date?
    
    
}
