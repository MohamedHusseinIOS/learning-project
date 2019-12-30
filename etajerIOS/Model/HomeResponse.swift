//
//  HomeResponse.swift
//  etajerIOS
//
//  Created by mohamed on 7/31/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation


struct HomeResponse: BaseModel {
    
    var ads1: [Ads]?
    var ads2: [Ads]?
    var ads3: [Ads]?
    var categories: [Category]?
    var latestProducts: [Product]?
    var latestAuctions: [Product]?
    var adsUnderAuctions: [Ads]?
    var bottomCategories: [Category]?
    
    enum CodingKeys: String, CodingKey{
        case ads1
        case ads2
        case ads3
        case categories
        case latestProducts
        case latestAuctions
        case adsUnderAuctions
        case bottomCategories
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        ads1                = try container.decode([Ads].self, forKey: .ads1)
        ads2                = try container.decode([Ads].self, forKey: .ads2)
        ads3                = try container.decode([Ads].self, forKey: .ads3)
        categories          = try container.decode([Category].self, forKey: .categories)
        latestProducts      = try container.decode([Product].self, forKey: .latestProducts)
        latestAuctions      = try container.decode([Product].self, forKey: .latestAuctions)
        adsUnderAuctions    = try container.decode([Ads].self, forKey: .adsUnderAuctions)
        bottomCategories    = try container.decode([Category].self, forKey: .bottomCategories)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(ads1.self, forKey: .ads1)
        try container.encode(ads2.self, forKey: .ads2)
        try container.encode(ads3.self, forKey: .ads3)
        try container.encode(categories.self, forKey: .categories)
        try container.encode(latestProducts.self, forKey: .latestProducts)
        try container.encode(latestAuctions.self, forKey: .latestAuctions)
        try container.encode(adsUnderAuctions.self, forKey: .adsUnderAuctions)
        try container.encode(bottomCategories.self, forKey: .bottomCategories)
    }
}

struct Ads: BaseModel {
    
    let area : Int?
    let bannerBaseUrl : String?
    let bannerPath : String?
    let createdAt : Int?
    let id : Int?
    let name : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        case area
        case bannerBaseUrl
        case bannerPath
        case createdAt
        case id
        case name
        case url
    }
}
