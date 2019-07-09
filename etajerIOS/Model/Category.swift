//
//  Category.swift
//  etajerIOS
//
//  Created by mohamed on 7/7/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

struct Category: Codable{
    
    var title: String?
    var items: Array<String>? = ["", "" , "" , ""]
    
    init(title: String) {
        self.title = title
    }
    
    enum CodingKeys: String, CodingKey{
        case title
    }
}
