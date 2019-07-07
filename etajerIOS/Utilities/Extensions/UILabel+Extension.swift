//
//  UILabel+Extension.swift
//  etajerIOS
//
//  Created by mohamed on 7/7/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    
    @IBInspectable
    var LocalizedText: String{
        set{
            self.text = newValue.localized()
        }
        get{
            guard let txt = self.text else{return ""}
            return txt.localized()
        }
    }
}
