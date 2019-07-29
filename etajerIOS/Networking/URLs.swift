//
//  URLs.swift
//  etajerIOS
//
//  Created by mohamed on 7/29/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

enum URLs: String {
    
    case login = "/api/v1/user/login"
    
    var URL: String{
        return "http://etajer.maxsys.sa" + self.rawValue
    }
}
