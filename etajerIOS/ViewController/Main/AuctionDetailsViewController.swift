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
    var productId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activeSkeleton()
        viewModel.getProductDetails(id: productId)
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
        
        viewModel.output
            .images
            .bind { [unowned self] (_) in
                self.hideSkeleton()
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
    
    func updateUI(_ item: Product){
        let lang = AppUtility.shared.currentLang
        let isAr = lang == .ar
        titleLbl.text = isAr ? item.titleAr : item.titleEn
        
        let imgUrl = getImagesUrl(images: item.images).first
        bigImg.kf.setImage(with: imgUrl, placeholder: #imageLiteral(resourceName: "img_placeholder"), options: nil, progressBlock: nil) {[unowned self] (res) in
            self.bigImg.hideSkeleton()
        }
        itemNameLbl.text = isAr ? item.titleAr : item.titleEn
        lastOverbidLbl.text = "\(item.auctionLastPrice ?? "0.0") \(S_R.localized())"
        //sealerNameLbl.text = ""
        ratingView.rating = Double(item.rating ?? "0") ?? 0.0
        itemShortDescriptionLbl.text = item.shortDesc
        numberOfBidding.text = "\(item.activateBuyNow ?? 0)"
        
        buyNowBtn.setTitle("\(BUY_NOW_WITH_PRICE.localized()) 22000 \(S_R.localized())", for: .normal)
    }
    
    func getImagesUrl(images: [ImageModel]?) -> [URL] {
        var urls = [URL]()
        images?.forEach({ (imageModel) in
            let baseUrl = imageModel.baseUrl ?? ""
            let imgPath = imageModel.path ?? ""
            let strUrl = baseUrl + "/" + imgPath
            guard let url = URL(string: strUrl) else { return }
            urls.append(url)
        })
        return urls
    }
    
    func activeSkeleton(){
        bigImg.showAnimatedGradientSkeleton()
        titleLbl.showAnimatedGradientSkeleton()
        itemNameLbl.showAnimatedGradientSkeleton()
        lastOverbidLbl.showAnimatedGradientSkeleton()
        ratingView.showAnimatedGradientSkeleton()
        itemShortDescriptionLbl.showAnimatedGradientSkeleton()
        sellerNameLbl.showAnimatedGradientSkeleton()
        imagesCollectionView.showAnimatedGradientSkeleton()
    }
    
    func hideSkeleton(){
        bigImg.hideSkeleton()
        titleLbl.hideSkeleton()
        itemNameLbl.hideSkeleton()
        lastOverbidLbl.hideSkeleton()
        ratingView.hideSkeleton()
        itemShortDescriptionLbl.hideSkeleton()
        sellerNameLbl.hideSkeleton()
        imagesCollectionView.hideSkeleton()
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
                
                let baseUrl = image.baseUrl ?? ""
                let imgPath = image.path ?? ""
                let strUrl = baseUrl + "/" + imgPath
                let url = URL(string: strUrl)
                cell.itemImg.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "img_placeholder"), options: nil, progressBlock: nil, completionHandler: { (res) in
                    cell.itemImg.hideSkeleton()
                })
                return cell
            }.disposed(by: bag)
    }
    
    func didSelectImageAt(indexPath: IndexPath){
        guard let cell = imagesCollectionView.cellForItem(at: indexPath) as? ImageCell else {return}
        bigImg.image = cell.itemImg.image
    }
}
