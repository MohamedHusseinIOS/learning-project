//
//  Favorrites.swift
//  etajerIOS
//
//  Created by mohamed on 8/26/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

struct FavoriteProductsResponse: BaseModel{
    
    let meta: FavoritesMeta?
    let products: [Product]?
    
    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        meta             = try container.decode(FavoritesMeta.self, forKey: .meta)
        products         = try container.decode([Product].self, forKey: .items)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(meta.self, forKey: .meta)
        try container.encode(products.self, forKey: .items)
    }
}

struct FavoriteStoresResponse: BaseModel{
    
    let meta : FavoritesMeta?
    let stores : [Store]?
    
    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        meta           = try container.decode(FavoritesMeta.self, forKey: .meta)
        stores         = try container.decode([Store].self, forKey: .items)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(meta.self, forKey: .meta)
        try container.encode(stores.self, forKey: .items)
    }
}

struct Store: BaseModel {
   
    //enum CodingKeys: String, CodingKey {}
}

struct FavoritesMeta: BaseModel {
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
