//
//  Category.swift
//  etajerIOS
//
//  Created by mohamed on 7/7/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import UIKit

struct Categories: BaseModel {
    
    var categories: [Category]?
    
    enum CodingKeys: String, CodingKey{
        case categories
    }
}

struct Category: BaseModel{
    
    var id: Int?
    var name: String?
    var isShipAble: Int?
    var acceptAuction: Int?
    var theIcon: String?
    var theBanner: String?
    var childs: [Category]?
    var products: Product?
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case isShipAble
        case acceptAuction
        case theIcon = "theIcon"
        case theBanner = "theBanner"
        case childs
        case products
    }
}

struct Item: Codable, Decoderable {
    
    var name: String?
    var price: String?
    var image: UIImage?
    var images: [UIImage]?
    var rating: Int?
    var overbid: String?
    
    enum CodingKeys: String, CodingKey{
        case name
        case price
//        case image
//        case images
        case rating
        case overbid
    }
}

