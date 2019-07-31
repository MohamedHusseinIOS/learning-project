//
//  ErrorModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/30/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

struct ErrorModel: BaseModel{
    
    var name: String?
    var field: String?
    var message: String?
    var status: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case field
        case message
        case status
    }
}
