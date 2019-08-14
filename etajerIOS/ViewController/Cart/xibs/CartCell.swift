//
//  CartCell.swift
//  etajerIOS
//
//  Created by mohamed on 7/22/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxSwift

class CartCell: UITableViewCell {

    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var sealLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var numberOfItemsContainer: UIView!
    @IBOutlet weak var increaseBtn: UIButton!
    @IBOutlet weak var decteaseBtn: UIButton!
    @IBOutlet weak var numberOfItemsLbl: UILabel!
    
    var bag = DisposeBag()
    var deleteAction: (()->Void)?
    var numberOfItems = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func prepareForReuse() {
        bag = DisposeBag()
    }
    
    func bindOnData(_ data: CartProduct) {
        
        self.itemImg.image = #imageLiteral(resourceName: "carpet")
        self.sealLbl.text = "99 \(S_R.localized())"
        self.priceLbl.text = "99 \(S_R.localized())"
        
        deleteBtn.rx
            .tap
            .bind {[unowned self] (_) in
                self.deleteAction?()
        }.disposed(by: bag)
        
        increaseBtn.rx
            .tap
            .bind {[unowned self] (_) in
                self.numberOfItems += 1
                self.numberOfItemsLbl.text = "\(self.numberOfItems)"
        }.disposed(by: bag)
        
        decteaseBtn.rx
            .tap
            .bind {[unowned self] (_) in
                if self.numberOfItems > 1 {
                    self.numberOfItems -= 1
                    self.numberOfItemsLbl.text = "\(self.numberOfItems)"
                }
        }.disposed(by: bag)
    }
}
