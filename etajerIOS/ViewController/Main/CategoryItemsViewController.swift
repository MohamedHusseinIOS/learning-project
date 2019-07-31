//
//  CategoryItemsViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/14/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxCocoa

class CategoryItemsViewController: BaseViewController {

    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    var isAuction: Bool?
    let viewModel = CategoryItemsViewModel()
    var items: [Item]?
    var items2: [Item]? = [Item(name: "شاشة سامسونج",
                               price: "3000 ر.س",
                               image: #imageLiteral(resourceName: "screen"),
                               images: nil,
                               rating: 3,
                               overbid: ""),
                          Item(name: "لكرس إى اس 350",
                               price: "45000 ر.س",
                               image: #imageLiteral(resourceName: "lexus"),
                               images: nil,
                               rating: 5,
                               overbid: ""),
                          Item(name: "لكرس إى اس 350",
                               price: "45000 ر.س",
                               image: #imageLiteral(resourceName: "lexus"),
                               images: nil,
                               rating: 5,
                               overbid: ""),
                          Item(name: "شاشة سامسونج",
                               price: "3000 ر.س",
                               image: #imageLiteral(resourceName: "screen"),
                               images: nil,
                               rating: 3,
                               overbid: ""),
                          Item(name: "لكرس إى اس 350",
                               price: "45000 ر.س",
                               image: #imageLiteral(resourceName: "lexus"),
                               images: nil,
                               rating: 5,
                               overbid: ""),
                          Item(name: "لكرس إى اس 350",
                               price: "45000 ر.س",
                               image: #imageLiteral(resourceName: "lexus"),
                               images: nil,
                               rating: 5,
                               overbid: ""),
                          Item(name: "شاشة سامسونج",
                               price: "3000 ر.س",
                               image: #imageLiteral(resourceName: "screen"),
                               images: nil,
                               rating: 3,
                               overbid: ""),
                          Item(name: "لكرس إى اس 350",
                               price: "45000 ر.س",
                               image: #imageLiteral(resourceName: "lexus"),
                               images: nil,
                               rating: 5,
                               overbid: ""),
                          Item(name: "لكرس إى اس 350",
                               price: "45000 ر.س",
                               image: #imageLiteral(resourceName: "lexus"),
                               images: nil,
                               rating: 5,
                               overbid: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureUI() {
        super.configureUI()
        titleLbl.text = title
        changeItemOverBid()
        registerCell()
        configureCategoryCollection()
        
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
        
        viewModel.input
            .items
            .onNext(items2 ?? [])
        
        itemsCollectionView.rx.itemSelected.subscribe {[unowned self] (event) in
            guard let indexPath = event.element else { return }
            self.didSelectItemIn(indexPath: indexPath)
        }.disposed(by: bag)
    }
    
    func registerCell(){
        let nib = UINib(nibName: "ItemsCell", bundle: .main)
        itemsCollectionView.register(nib, forCellWithReuseIdentifier: "ItemsCell")
    }
    
    func changeItemOverBid(){
        items2?.enumerated().forEach({[unowned self] (element) in
            if self.isAuction ?? false {
                var item = element.element
                item.overbid = LAST_OVERBID.localized()
                self.items2?[element.offset] = item
            }
        })
    }
    
    func configureCategoryCollection(){
        
        itemsCollectionView.delegate = nil
        itemsCollectionView.dataSource = nil
        
        let flowLayout = UICollectionViewFlowLayout()
        let width = (AppUtility.shared.screenWidth - CGFloat(10)) / CGFloat(2)
        flowLayout.itemSize = CGSize(width: width, height: 286)
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset.left = 5
        flowLayout.sectionInset.right = 5
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        itemsCollectionView.setCollectionViewLayout(flowLayout, animated: true)
        itemsCollectionView.scrollsToTop = true
        viewModel.output
            .items
            .bind(to: itemsCollectionView.rx.items){ collectionView, item, element in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsCell", for: IndexPath(item: item, section: 0)) as? ItemsCell else { return ItemsCell() }
                //cell.bindOn(item: element)
                cell.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                return cell
            }.disposed(by: bag)
        
        itemsCollectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    func didSelectItemIn(indexPath: IndexPath){
        guard !(isAuction ?? false) else {
            NavigationCoordinator.shared.mainNavigator.navigate(To: .auctionDetailsViewController)
            return
        }
        NavigationCoordinator.shared.mainNavigator.navigate(To: .itemDetailsViewController)
    }

}
