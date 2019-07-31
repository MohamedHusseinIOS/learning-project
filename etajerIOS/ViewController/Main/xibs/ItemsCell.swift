//
//  ItemsCell.swift
//  etajerIOS
//
//  Created by mohamed on 7/9/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import Cosmos

class ItemsCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var lastOverbidLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingView.settings.updateOnTouch = false
    }
    
    func bindOn(item: Product){
        itemImg.contentMode = .scaleAspectFit
        //Kingfisher
        itemNameLbl.text = item.titleEn
        lastOverbidLbl.text = item.auctionPrice
        priceLbl.text = item.sellPrice
        ratingView.rating = Double(item.sellQty ?? 0) / 2
    }
}
