//
//  Product.swift
//  etajerIOS
//
//  Created by mohamed on 7/31/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

struct Product: BaseModel{
    
    let activateBuyNow : Int?
    let auctionLastPrice : String?
    let auctionMinPrice : String?
    let auctionPrice : String?
    let auctionSellPrice : String?
    let boldTitle : Bool?
    let categoryId : Int?
    let createdAt : Int?
    let desc : String?
    let freeInternational : Bool?
    let freeShipping : Bool?
    let galleryPlus : Bool?
    let id : Int?
    let imgBaseUrl : String?
    let imgPath : String?
    let isShipAble : Bool?
    let pickupAddress : String?
    let priceType : Int?
    let productStatus : Int?
    let returnPolicy : Int?
    let secondCategoryId : Int?
    let sellLessPrice : Int?
    let sellPrice : String?
    let sellQty : Int?
    let shippingMethod : String?
    let shortDesc : String?
    let sku : String?
    let status : Int?
    let subTitleAr : String?
    let subTitleEn : String?
    let titleAr : String?
    let titleEn : String?
    let twoCategories : Int?
    let unshipEmail : String?
    let unshipMobile : String?
    let unshipName : String?
    let unshipViewInfo : String?
    let upc : String?
    let updatedAt : Int?
    let useSubtitle : Int?
    let usedStatus : Int?
    let userId : Int?
    let viewAt : String?
    let viewDuration : Int?
    let weight : Double?
    let weightUnit : Double?
    
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
    }
}
