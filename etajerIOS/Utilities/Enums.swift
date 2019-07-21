//
//  Enums.swift
//  Fundaqah
//
//  Created by mohamed on 7/1/19.
//  Copyright © 2019 mohamed ismail. All rights reserved.
//

import Foundation
import UIKit

enum MenuElements: String {
    
    case MOBILES_AND_TAPLETS
    case CLOTHES_AND_SHOSES_AND_ACCESSORIES
    case HELTH_AND_SELF_CARE
    case CUMPUTERS_AND_NETWORKS_AND_PROGRAMS
    case GARDEN_SUPPLIES
    case ELECTRONICS
    case FURNITURE_AND_HOUSE_DECORATION
    case KITCHEN_AND_HOUSE_SUPPLIES
    case JEWELERY_AND_ACCESSORIES
    case OFFICE_EQUIPMENTS
    case CHANGE_LANG
    
    static func element(row: Int) -> MenuElements{
        switch row {
        case 0:
            return .MOBILES_AND_TAPLETS
        case 1:
            return .CLOTHES_AND_SHOSES_AND_ACCESSORIES
        case 2:
            return .HELTH_AND_SELF_CARE
        case 3:
            return .CUMPUTERS_AND_NETWORKS_AND_PROGRAMS
        case 4:
            return .GARDEN_SUPPLIES
        case 5:
            return .ELECTRONICS
        case 6:
            return .FURNITURE_AND_HOUSE_DECORATION
        case 7:
            return .KITCHEN_AND_HOUSE_SUPPLIES
        case 8:
            return .JEWELERY_AND_ACCESSORIES
        case 9:
            return .OFFICE_EQUIPMENTS
        case 10:
            return .CHANGE_LANG
        default:
            return .ELECTRONICS
        }
    }
    
    var title: String {
        return rawValue.localized()
    }
}

enum MyAccountElements: String{
    
    case MY_ORDERS
    case NOTIFICATION
    case ADDRESSES
    case FAVORITES
    case PAYMENT_INFO
    case MY_INFO
    
    static func element(row: Int) -> MyAccountElements{
        switch row {
        case 0:
            return .MY_ORDERS
        case 1:
            return .NOTIFICATION
        case 2:
            return .ADDRESSES
        case 3:
            return .FAVORITES
        case 4:
            return .PAYMENT_INFO
        case 5:
            return .MY_INFO
        default:
            return .MY_INFO
        }
    }
    
    var title: String {
        return rawValue.localized()
    }
    
    var icon: UIImage{
        switch self {
        case .MY_ORDERS:
            return #imageLiteral(resourceName: "orders")
        case .NOTIFICATION:
            return #imageLiteral(resourceName: "notification1")
        case .ADDRESSES:
            return #imageLiteral(resourceName: "addresses")
        case .FAVORITES:
            return #imageLiteral(resourceName: "favoreites1")
        case .PAYMENT_INFO:
            return #imageLiteral(resourceName: "buyment-info")
        case .MY_INFO:
            return #imageLiteral(resourceName: "my info")
        }
    }
}
