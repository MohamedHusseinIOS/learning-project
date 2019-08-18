//
//  Notification.swift
//  etajerIOS
//
//  Created by mohamed on 8/18/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

struct NotificationResponse: BaseModel{
    
    let meta : NotificationMeta?
    let notifications : [Notification]?
    
    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case items
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        meta                = try container.decode(NotificationMeta.self, forKey: .meta)
        notifications       = try container.decode([Notification].self, forKey: .items)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(meta.self, forKey: .meta)
        try container.encode(notifications.self, forKey: .items)
    }
}

struct Notification: BaseModel {
    
}

struct NotificationMeta: BaseModel {
    let currentPage : Int?
    let pageCount : Int?
    let perPage : Int?
    let totalCount : Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPage
        case pageCount
        case perPage
        case totalCount
    }
}
