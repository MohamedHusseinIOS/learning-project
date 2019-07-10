//
//  Category.swift
//  etajerIOS
//
//  Created by mohamed on 7/7/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import UIKit

struct Category: Codable{
    
    var title: String?
    var items: Array<Item>?
    
    init(title: String, items: [Item]) {
        self.title = title
        self.items = items
    }
    
    enum CodingKeys: String, CodingKey{
        case title
    }
}

struct Item: Codable {
    
    var name: String?
    var price: String?
    var image: UIImage?
    var rating: Int?
    var overbid: String?
    
    init(name: String, price: String, image: UIImage, rating: Int, overbid: String) {
        self.name = name
        self.price = price
        self.image = image
        self.rating = rating
        self.overbid = overbid
    }
    
    enum CodingKeys: String, CodingKey{
        case name
        case price
    }
}
