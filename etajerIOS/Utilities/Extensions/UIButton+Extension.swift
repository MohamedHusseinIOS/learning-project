//
//  UIButton+Extension.swift
//  etajerIOS
//
//  Created by mohamed on 7/8/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    var imageContentMode: ContentMode{
        set{
            self.imageView?.contentMode = newValue
        }
        get{
            guard let contentMode = self.imageView?.contentMode else { return .redraw }
            return contentMode
        }
    }
    
    @IBInspectable
    var localizedTitle: String{
        set{
            self.setTitle(newValue.localized(), for: .normal)
        }
        get{
            return self.localizedTitle
        }
    }
}
