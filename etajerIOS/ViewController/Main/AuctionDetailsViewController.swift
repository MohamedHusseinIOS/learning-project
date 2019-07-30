//
//  AuctionDetailsViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/16/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import Cosmos

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
    @IBOutlet weak var lastOverbidLbl: UILabel!
    @IBOutlet weak var numberOfBidding: UILabel!
    
    @IBOutlet weak var bidNowBtn: UIButton!
    @IBOutlet weak var buyNowBtn: UIButton!
    @IBOutlet weak var sendOfferBtn: UIButton!
    
    let viewModel = AuctionDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = Item(name: "سماعة بلوتوث",
                        price: "100",
                        image:  #imageLiteral(resourceName: "carpet"),
                        images: [#imageLiteral(resourceName: "lexus"), #imageLiteral(resourceName: "carpet"), #imageLiteral(resourceName: "screen"), #imageLiteral(resourceName: "baner1")],
                        rating: 5,
                        overbid: "")
        viewModel.input.item.onNext(item)
    }
    
    override func configureUI() {
        super.configureUI()
        registerCell()
        configureCollectionView()
        
        if AppUtility.shared.currentLang == .ar {
            backImg.image = #imageLiteral(resourceName: "white-back-ar")
        } else {
            backImg.image = #imageLiteral(resourceName: "white-back-en")
        }
        
        backBtn.rx
            .tap
            .subscribe {[unowned self] (_) in
                self.navigationController?.popViewController(animated: true)
            }.disposed(by: bag)
        
        likeBtn.rx
            .tap
            .subscribe {[unowned self] (_) in
                self.likeAction()
            }.disposed(by: bag)
        
        shareBtn.rx
            .tap
            .subscribe {[unowned self] (_) in
                self.shareAction()
            }.disposed(by: bag)
        
        imagesCollectionView.rx
            .itemSelected
            .subscribe {[unowned self] (event) in
                guard let indexPath = event.element else { return }
                self.didSelectImageAt(indexPath: indexPath)
            }.disposed(by: bag)
    }
    
    override func configureData(){
        viewModel.output
            .item
            .subscribe {[unowned self] (event) in
                guard let item = event.element else { return }
                self.updateUI(item)
            }.disposed(by: bag)
    }
    
    func registerCell(){
        let nib = UINib(nibName: "ImageCell", bundle: .main)
        imagesCollectionView.register(nib, forCellWithReuseIdentifier: "ImageCell")
    }
    
    func likeAction(){
        if likeBtn.imageView?.image == #imageLiteral(resourceName: "like1"){
            likeBtn.setImage(#imageLiteral(resourceName: "likeEmpty"), for: .normal)
        } else {
            likeBtn.setImage(#imageLiteral(resourceName: "like1"), for: .normal)
        }
    }
    
    func shareAction(){
        guard let title = itemNameLbl.text else { return }
        let items = [title]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    func updateUI(_ item: Item){
        titleLbl.text = item.name
        bigImg.image = item.images?.first
        itemNameLbl.text = item.name
        lastOverbidLbl.text = "\(item.price ?? "0.0") \(S_R.localized())"
        //sealerNameLbl.text = ""
        ratingView.rating = Double(item.rating ?? 0)
        //itemShortDescriptionLbl.text = ""
        
        buyNowBtn.setTitle("\(BUY_NOW_WITH_PRICE.localized()) 22000 \(S_R.localized())", for: .normal)
    }
    
    func configureCollectionView(){
        imagesCollectionView.delegate = nil
        imagesCollectionView.dataSource = nil
        
        let flowLayout = UICollectionViewFlowLayout()
        let width = (imagesCollectionView.frame.size.width - CGFloat(10)) / CGFloat(4)
        flowLayout.itemSize = CGSize(width: width, height: 90)
        flowLayout.scrollDirection = .horizontal
        
        viewModel.output
            .images
            .bind(to: imagesCollectionView.rx.items){ collectionView, item, image in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: IndexPath(item: item, section: 0)) as? ImageCell else {return ImageCell()}
                cell.itemImg.image = image
                return cell
            }.disposed(by: bag)
    }
    
    func didSelectImageAt(indexPath: IndexPath){
        guard let cell = imagesCollectionView.cellForItem(at: indexPath) as? ImageCell else {return}
        bigImg.image = cell.itemImg.image
    }
}
