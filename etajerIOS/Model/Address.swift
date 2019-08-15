//
//  Address.swift
//  etajerIOS
//
//  Created by mohamed on 8/15/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

struct Addresses: BaseModel {
    let addresses: [Address]
    
    enum CodingKeys: String, CodingKey{
        case addresses
    }
}

struct Address: BaseModel{
    let additionalNumber : String?
    let area : String?
    let building : String?
    let city : String?
    let country : String?
    let desc : String?
    let id : Int?
    let mobile : String?
    let name : String?
    let postal : String?
    let street : String?
    let theCountry : String?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case additionalNumber
        case area
        case building
        case city
        case country
        case desc
        case id
        case mobile
        case name
        case postal
        case street
        case theCountry
        case userId
    }
}
