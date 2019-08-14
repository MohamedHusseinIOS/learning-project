//
//  Cart.swift
//  etajerIOS
//
//  Created by mohamed on 8/14/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

struct CartResponse: BaseModel {
    let cart: Cart?
    let byShippment: [String: Product]?
    let isUpdated: Bool?
    
    enum CodingKeys: String, CodingKey {
        case cart
        case byShippment
        case isUpdated
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        cart                = try container.decode(Cart.self, forKey: .cart)
        byShippment         = try container.decode([String: Product].self, forKey: .byShippment)
        isUpdated           = try container.decode(Bool.self, forKey: .isUpdated)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(cart.self, forKey: .cart)
        try container.encode(byShippment.self, forKey: .byShippment)
        try container.encode(isUpdated.self, forKey: .isUpdated)
    }
}

struct Cart: BaseModel {
    let id: Int?
    let userId: String?
    let hashId: String?
    let status: Int?
    let paymentMethod: String?
    let paymentDetails: String?
    let shippingMethod: String?
    let shippingDetails: String?
    let voucherCode: String?
    let subTotal: String?
    let paymentFees: String?
    let shippingFees: String?
    let voucherDiscount: String?
    let vat: String?
    let totalOrder: String?
    let products: [Product]?
    let shippments: [String]?
    
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case hashId
        case status
        case paymentMethod
        case paymentDetails
        case shippingMethod
        case shippingDetails
        case voucherCode
        case subTotal
        case paymentFees
        case shippingFees
        case voucherDiscount
        case vat
        case totalOrder
        case products
        case shippments
    }
}
