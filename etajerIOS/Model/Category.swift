//
//  Category.swift
//  etajerIOS
//
//  Created by mohamed on 7/7/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import UIKit

struct Category: Codable, Decoderable{
    
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

struct Item: Codable, Decoderable {
    
    var name: String?
    var price: String?
    var image: UIImage?
    var rating: Int?
    var overbid: String?
    
    enum CodingKeys: String, CodingKey{
        case name
        case price
        case image
        case rating
        case overbid
    }
}

extension Item {
    func encode(to encoder: Encoder) throws {

    }

    init(from decoder: Decoder) throws {

    }
}
