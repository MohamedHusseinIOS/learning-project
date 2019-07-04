//
//  Enums.swift
//  Fundaqah
//
//  Created by mohamed on 7/1/19.
//  Copyright © 2019 mohamed ismail. All rights reserved.
//

import Foundation
import UIKit

enum MenuElements: Int {
    case home           = 0
    
    
    var icon: UIImage {
        switch self {
        case .home: return #imageLiteral(resourceName: "Home")
       
        }
    }
    
    var title: String {
        switch self {
        case .home: return "الرئيسية"
            
        }
    }
}
