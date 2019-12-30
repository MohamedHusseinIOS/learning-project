//
//  MyOrder.swift
//  etajerIOS
//
//  Created by mohamed on 8/21/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

struct MyOrdersResponse: BaseModel{
    
    let meta : MyOrdersMeta?
    let orders : [Order]?
    
    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case items
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        meta                = try container.decode(MyOrdersMeta.self, forKey: .meta)
        orders              = try container.decode([Order].self, forKey: .items)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(meta.self, forKey: .meta)
        try container.encode(orders.self, forKey: .items)
    }
}

struct Order: BaseModel {
    
    //TODO: All Properties must be Var
    
//    enum CodingKeys: String, CodingKey {
//
//    }
    
    init() {}
}

struct MyOrdersMeta: BaseModel {
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
