//
//  ItemsCell.swift
//  etajerIOS
//
//  Created by mohamed on 7/9/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher

class ItemsCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var lastOverbidLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingView.settings.updateOnTouch = false
        activeSkeleton()
    }
    
    func bindOn(item: Product){
        let isEng = AppUtility.shared.currentLang == .en
        itemImg.contentMode = .scaleAspectFit
        itemNameLbl.text = isEng ? item.titleEn : item.titleAr
        lastOverbidLbl.text = item.auctionPrice
        priceLbl.text = item.sellPrice
        ratingView.rating = Double(item.sellQty ?? 0) / 2
        let strUrl = (item.imgBaseUrl ?? "") + "/" + (item.imgPath ?? "")
        let url = URL(string: strUrl)
        itemImg.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: { [unowned self] (_, _) in
            self.itemImg.showAnimatedSkeleton()
        }) { [unowned self] (result) in
            switch result {
            case .success( _):
                self.itemImg.hideSkeleton()
            case .failure( _):
                self.itemImg.showAnimatedGradientSkeleton()
            }
        }
        stopSkeleton()
    }
    
    func activeSkeleton(){
        itemNameLbl.showAnimatedGradientSkeleton()
        lastOverbidLbl.showAnimatedGradientSkeleton()
        priceLbl.showAnimatedGradientSkeleton()
        ratingView.showAnimatedGradientSkeleton()
    }
    
    func stopSkeleton(){
        itemNameLbl.hideSkeleton()
        lastOverbidLbl.hideSkeleton()
        priceLbl.hideSkeleton()
        ratingView.hideSkeleton()
    }
}
