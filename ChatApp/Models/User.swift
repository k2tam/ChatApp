//
//  User.swift
//  ChatApp
//
//  Created by k2 tam on 13/08/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable{
    @DocumentID var id:String?
    var firstName: String?
    var lastName: String?
    var phone: String?
    var photo: String?
}
