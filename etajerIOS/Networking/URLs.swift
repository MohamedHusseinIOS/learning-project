//
//  URLs.swift
//  etajerIOS
//
//  Created by mohamed on 7/29/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

enum URLs: String {
    
    case login                      = "/api/v1/user/login"
    case signup                     = "/api/v1/user/signup"
    case requestResetPassword       = "/api/v1/user/request-reset-password"
    case currentUser                = "/api/v1/user/current"
    case logout                     = "/api/v1/user/logout"
    
    case products                   = "/api/v1/products"
    case productDetails             = "/api/v1/products/details?"
    case categories                 = "/api/v1/products/categories"
    case homePage                   = "/api/v1/products/homepage"
    
    case getCart                    = "/api/v1/order/cart?hash=111"
    case addToCart                  = "/api/v1/order/add-to-cart?hash=111"
    case removeFormCart             = "/api/v1/order/remove-from-cart?hash=111"
    
    case getAddresses               = "/api/v1/user/addresses"
    case newAddress                 = "/api/v1/user/new-address"
    
    case getNotifications           = "/api/v1/notifications/index"
    
    
    var URL: String{
        return AppUtility.shared.currentEnviroment + self.rawValue
    }
}
