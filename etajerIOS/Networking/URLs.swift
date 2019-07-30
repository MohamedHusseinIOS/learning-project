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
    case logout                     = "/api/v1/user/logout"
    
    var URL: String{
        return AppUtility.shared.currentEnviroment + self.rawValue
    }
}
