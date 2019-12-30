//
//  Product.swift
//  etajerIOS
//
//  Created by mohamed on 7/31/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

struct Items: BaseModel{
    
    let items: [Product]?

    enum CodingKeys: String,CodingKey{
        case items
    }
}

struct Products: BaseModel {
    let product: Product?
    enum CodingKeys: String, CodingKey{
        case product
    }
}

struct Product: BaseModel{
    
    var activateBuyNow : Int?
    var auctionLastPrice : String?
    var auctionMinPrice : String?
    var auctionPrice : String?
    var auctionSellPrice : String?
    var boldTitle : Int?
    var categoryId : Int?
    var createdAt : Int?
    var desc : String?
    var freeInternational : Int?
    var freeShipping : Int?
    var galleryPlus : Int?
    var id : Int?
    var rating: Double?
    var imgBaseUrl : String?
    var imgPath : String?
    var isShipAble : Int?
    var pickupAddress : Int?
    var priceType : Int?
    var productStatus : Int?
    var returnPolicy : Int?
    var secondCategoryId : Int?
    var sellLessPrice : Int?
    var sellPrice : String?
    var sellQty : Int?
    var shippingMethod : String?
    var shortDesc : String?
    var sku : String?
    var status : Int?
    var subTitleAr : String?
    var subTitleEn : String?
    var titleAr : String?
    var titleEn : String?
    var twoCategories : Int?
    var unshipEmail : String?
    var unshipMobile : String?
    var unshipName : String?
    var unshipViewInfo : Int?
    var upc : String?
    var updatedAt : Int?
    var useSubtitle : Int?
    var usedStatus : String?
    var userId : Int?
    var viewAt : String?
    var viewDuration : Int?
    var weight : String?
    var weightUnit : Double?
    var images: [ImageModel]?
    var seller: User?
    var thumbUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case activateBuyNow
        case auctionLastPrice
        case auctionMinPrice
        case auctionPrice
        case auctionSellPrice
        case boldTitle
        case categoryId
        case createdAt
        case desc
        case freeInternational
        case freeShipping
        case galleryPlus
        case id
        case rating
        case imgBaseUrl
        case imgPath
        case isShipAble
        case pickupAddress
        case priceType
        case productStatus
        case returnPolicy
        case secondCategoryId
        case sellLessPrice
        case sellPrice
        case sellQty
        case shippingMethod
        case shortDesc
        case sku
        case status
        case subTitleAr
        case subTitleEn
        case titleAr
        case titleEn
        case twoCategories
        case unshipEmail
        case unshipMobile
        case unshipName
        case unshipViewInfo
        case upc
        case updatedAt
        case useSubtitle
        case usedStatus
        case userId
        case viewAt
        case viewDuration
        case weight
        case weightUnit
        case images
        case seller
        case thumbUrl
    }
    
    init() {}
}


struct Images: BaseModel {
    
    var images: Array<ImageModel>?
    
    enum CodingKeys: String, CodingKey{
        case images
    }
}

struct ImageModel: BaseModel {
    var path: String?
    var baseUrl: String?
    var type: String?
    var size: Int?
    var name: String?
    var order: String?
    var timestamp: Int?
    
    enum CodingKeys: String, CodingKey{
        case path
        case baseUrl
        case type
        case size
        case name
        case order
        case timestamp
    }
}
