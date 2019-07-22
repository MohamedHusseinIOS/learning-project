//
//  CartHeaderView.swift
//  etajerIOS
//
//  Created by mohamed on 7/22/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit

class CartHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func instanceFromNib() -> UIView {
        guard let view = UINib(nibName: "CartHeaderView", bundle: .main).instantiate(withOwner: nil, options: nil)[0] as? UIView else { return UIView() }
        return view
    }
    
    private func commonInit(){
        self.frame = self.bounds
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
