//
//  AuctionDetailsViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/16/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit

class AuctionDetailsViewController: BaseViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var bigImg: UIImageView!
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var sellerNameLbl: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var numberOfRatingLbl: UILabel!
    @IBOutlet weak var itemShortDescriptionLbl: UILabel!
    
    let viewModel = AuctionDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
