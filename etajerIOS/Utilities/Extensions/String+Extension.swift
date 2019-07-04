//
//  String+Extension.swift
//  etajerIOS
//
//  Created by mohamed on 7/4/19.
//  Copyright © 2019 mohamed ismail. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
    
    func clickableString(gotolink link: String, color: UIColor = #colorLiteral(red: 0.7213609132, green: 0, blue: 0, alpha: 1)) -> NSMutableAttributedString {
        let range = NSRange(location: 0, length: self.count - 1)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedString.addAttribute(.link, value: link, range: range)
        return attributedString
    }

}
