//
//  Constants.swift
//  etajerIOS
//
//  Created by mohamed on 7/7/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import UIKit

enum Constants: String{
    case font = "DINNextLTW23-Regular"
    case AppleLanguages
}

enum Colors{
    case Rose
    case PrimaryColor
    
    var value: UIColor{
        switch  self {
        case .Rose:
            return UIColor(red: 235/255, green: 85/255, blue: 91/255, alpha: 1)
        case .PrimaryColor:
            return #colorLiteral(red: 0.2761612535, green: 0.1481507123, blue: 0.3897372484, alpha: 1)
        }
        
    }
}
