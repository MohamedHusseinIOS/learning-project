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

struct AddressResponse: BaseModel {
    let address: Address
    
    enum CodingKeys: String, CodingKey{
        case address
    }
}

struct Address: BaseModel{
    var additionalNumber : String?
    var area : String?
    var building : String?
    var city : String?
    var country : String?
    var desc : String?
    var id : Int?
    var mobile : String?
    var name : String?
    var postal : String?
    var street : String?
    var theCountry : String?
    var userId : Int?
    
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
    
    init() {}
}
