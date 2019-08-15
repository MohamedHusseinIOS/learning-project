//
//  Cart.swift
//  etajerIOS
//
//  Created by mohamed on 8/14/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

struct CartResponse: BaseModel {
    var cart: Cart?
    let byShippment: [String: byShippmentResponse]?
    let isUpdated: Bool?
    
    enum CodingKeys: String, CodingKey {
        case cart
        case shippments
        case byShippment
        case isUpdated
    }
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        cart                = try container.decode(Cart.self, forKey: .cart)
        byShippment         = try container.decode([String: byShippmentResponse].self, forKey: .byShippment)
        isUpdated           = try container.decode(Bool.self, forKey: .isUpdated)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(cart.self, forKey: .cart)
        try container.encode(byShippment.self, forKey: .byShippment)
        try container.encode(isUpdated.self, forKey: .isUpdated)
    }
}

struct byShippmentResponse: BaseModel {
    
    let fees: Double?
    let items: [CartProduct]?
    let method: String?
    let name: String?
    let seller: Int?
    
    enum CodingKeys: String, CodingKey {
        case fees
        case items
        case method
        case name
        case seller
    }
}

struct AddToCartResponse: BaseModel {
    let cart: Cart?
    
    enum CodingKeys: String, CodingKey{
        case cart
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
    let products: [CartProduct]?
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

struct CartProduct: BaseModel {
    
    var id : Int?
    var price : String?
    var productId : Int?
    var qty : Int?
    var rating : Bool?
    var seller : User?
    var sellerId : Int?
    var shippingMethod : String?
    var shippmentId : String?
    var sku : String?
    var thumbUrl : String?
    var title : String?
    var upc : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case price
        case productId
        case qty
        case rating
        case seller
        case sellerId
        case shippingMethod
        case shippmentId
        case sku
        case thumbUrl
        case title
        case upc
    }
    
    init() {}
}
