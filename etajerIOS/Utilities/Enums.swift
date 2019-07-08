//
//  Enums.swift
//  Fundaqah
//
//  Created by mohamed on 7/1/19.
//  Copyright © 2019 mohamed ismail. All rights reserved.
//

import Foundation
import UIKit

enum AppLanguages: String{
    case en, ar
}

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
        default:
            return .ELECTRONICS
        }
        
    }
    
    var title: String {
        return rawValue.localized()
    }
}
