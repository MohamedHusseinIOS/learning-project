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
    
    func bindOn(item: Item){
        itemImg.contentMode = .scaleAspectFit
        itemImg.image = item.image
        itemNameLbl.text = item.name
        lastOverbidLbl.text = item.overbid
        priceLbl.text = item.price
        ratingView.rating = Double(item.rating ?? 0)
    }
}
