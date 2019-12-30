//
//  RadioSelectionBtn.swift
//  etajerIOS
//
//  Created by mohamed on 7/25/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit

@IBDesignable
class RadioSelectionBtn: UIButton {
    
    override var cornerRadius: CGFloat {
        get{
            return (self.frame.height / 2)
        }
        set{
            self.cornerRadius = newValue
        }
    }
    
    override var borderWidth: CGFloat{
        get{
            return 2
        }
        set{
            self.borderWidth = newValue
        }
    }
    
    override var borderColor: UIColor?{
        get{
            return #colorLiteral(red: 0.9215686275, green: 0.3333333333, blue: 0.3568627451, alpha: 1)
        }
        set{
            self.borderColor = newValue
        }
    }

}
