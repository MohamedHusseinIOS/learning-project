//
//  SignupReponse.swift
//  etajerIOS
//
//  Created by mohamed on 7/30/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

struct Response: Codable, Decoderable {
    
    var accessToken: String?
    var message: String?
    var identity: User?
    
    enum CodingKeys: String, CodingKey{
        case accessToken
        case message
        case identity
    }
}
