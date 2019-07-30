//
//  User.swift
//  etajerIOS
//
//  Created by mohamed on 7/30/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

struct User: Codable, Decoderable {
    
    var id: Int?
    var avatar: String?
    var name: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var mobile: String?
    var bankHoldername : String?
    var bankIban: String?
    var bankName: String?
    var createdAt: Date?
    
    enum CodingKeys: String, CodingKey{
        case id
        case avatar
        case name
        case firstName
        case lastName
        case email
        case mobile
        case bankHoldername
        case bankIban
        case bankName
        case createdAt
    }
}
