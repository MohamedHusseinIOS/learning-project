//
//  CartHeaderView.swift
//  etajerIOS
//
//  Created by mohamed on 7/22/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit

class CartHeaderView: UIView {

    
        
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cartImg: UIImageView!
    @IBOutlet weak var addressImg: UIImageView!
    @IBOutlet weak var paymentImg: UIImageView!
    @IBOutlet weak var doneImg: UIImageView!
    
    enum Page: Int {
        case cart = 1
        case address = 2
        case payment = 3
        case done = 4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    class func instanceFromNib() -> UIView {
        guard let view = UINib(nibName: "CartHeaderView", bundle: .main).instantiate(withOwner: self, options: nil)[0] as? UIView else { return UIView() }
        return view
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("CartHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func checkPage(_ page: Page) {
        switch page {
        case .cart:
            hideAllImages()
            cartImg.isHidden = false
        case .address:
            hideAllImages()
            cartImg.isHidden = false
            addressImg.isHidden = false
        case .payment:
            cartImg.isHidden = false
            addressImg.isHidden = false
            paymentImg.isHidden = false
            doneImg.isHidden = true
        case .done:
            cartImg.isHidden = false
            addressImg.isHidden = false
            paymentImg.isHidden = false
            doneImg.isHidden = false
        }
    }

    func hideAllImages(){
        cartImg.isHidden = true
        addressImg.isHidden = true
        paymentImg.isHidden = true
        doneImg.isHidden = true
    }
}
