//
//  AppUtility.swift
//  Fundaqah
//
//  Created by mohamed on 7/1/19.
//  Copyright © 2019 mohamed ismail. All rights reserved.
//

import Foundation
import UIKit

class AppUtility {
    
    static let shared = AppUtility()
    
    let interface = UIDevice.current.userInterfaceIdiom
    let orientation = UIDevice.current.orientation
    let primaryColor = #colorLiteral(red: 0.2761612535, green: 0.1481507123, blue: 0.3897372484, alpha: 1)
    
    private init() {}
    
    
}
