//
//  CartCell.swift
//  etajerIOS
//
//  Created by mohamed on 7/22/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

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
    
    static let reuseId = "CartCell"
    
    var parent: CartPageViewController?
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
        
        let url = URL(string: data.thumbUrl ?? "")
        self.itemImg.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "img_placeholder"), options: nil, progressBlock: nil) { (res) in
            //Code
        }
        self.sealLbl.text = ""
        self.priceLbl.text = "\(data.price ?? "") \(S_R.localized())"
        self.itemNameLbl.text = data.title
        self.numberOfItems = data.qty ?? 1
        self.numberOfItemsLbl.text = "\(data.qty ?? 1)"
        
        deleteBtn.rx
            .tap
            .bind {[unowned self] (_) in
                self.deleteAction?()
        }.disposed(by: bag)
        
        increaseBtn.rx
            .tap
            .bind {[unowned self] (_) in
                self.numberOfItems += 1
                //self.numberOfItemsLbl.text = "\(self.numberOfItems)"
                self.parent?.viewModel.changeQuitity(ofProduct: data.productId, by: self.numberOfItems)
        }.disposed(by: bag)
        
        decteaseBtn.rx
            .tap
            .bind {[unowned self] (_) in
                if self.numberOfItems > 1 {
                    self.numberOfItems -= 1
                    //self.numberOfItemsLbl.text = "\(self.numberOfItems)"
                    self.parent?.viewModel.changeQuitity(ofProduct: data.productId, by: self.numberOfItems)
                }
        }.disposed(by: bag)
    }
}
