//
//  ItemDetailsViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/16/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import Cosmos
import RxCocoa

class ItemDetailsViewController: BaseViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var bigImg: UIImageView!
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!
    @IBOutlet weak var sellerNameLbl: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var numberOfRatingLbl: UILabel!
    @IBOutlet weak var itemShortDescriptionLbl: UILabel!
    
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var increaseNumberOfItemsBtn: UIButton!
    @IBOutlet weak var decreaseNumberOfItemsBtn: UIButton!
    @IBOutlet weak var numberOfItemsLbl: UILabel!
    
    let viewModel = ItemDetailsViewModel()
    var numberOfItems = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = Item(name: "سماعة بلوتوث",
                        price: "100",
                        image:  #imageLiteral(resourceName: "carpet"),
                        images: [#imageLiteral(resourceName: "lexus"), #imageLiteral(resourceName: "carpet"), #imageLiteral(resourceName: "screen"), #imageLiteral(resourceName: "baner1")],
                        rating: 5,
                        overbid: nil)
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
        
        backBtn.rx.tap.subscribe {[unowned self] (_) in
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: bag)
        
        likeBtn.rx
            .tap
            .subscribe {[unowned self] (_) in
                if self.likeBtn.imageView?.image == #imageLiteral(resourceName: "like1"){
                    self.likeBtn.setImage(#imageLiteral(resourceName: "likeEmpty"), for: .normal)
                } else {
                    self.likeBtn.setImage(#imageLiteral(resourceName: "like1"), for: .normal)
                }
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
        
        increaseNumberOfItemsBtn.rx
            .tap
            .subscribe {[unowned self] (_) in
                self.numberOfItems = self.numberOfItems + 1
                self.numberOfItemsLbl.text = "\(self.numberOfItems)"
        }.disposed(by: bag)
        
        decreaseNumberOfItemsBtn.rx
            .tap
            .subscribe {[unowned self] (_) in
                if self.numberOfItems > 0{
                    self.numberOfItems = self.numberOfItems - 1
                    self.numberOfItemsLbl.text = "\(self.numberOfItems)"
                }
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
        itemPriceLbl.text = "\(item.price ?? "0.0") \(S_R.localized())"
        //sealerNameLbl.text = ""
        ratingView.rating = Double(item.rating ?? 0)
        //itemShortDescriptionLbl.text = ""
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
