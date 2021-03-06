//
//  FavoritesViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/18/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit

class FavoritesViewController: BaseViewController {

    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var productAndShopSegment: UISegmentedControl!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    let viewModel = FavoritesViewModel()
    var isAuction: Bool?
    var items: [Product]?
    
    let refreshControl = UIRefreshControl()
    let indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        itemsCollectionView.addSubview(refreshControl)
        callFavoritesAPI()
    }
    
    override func configureUI() {
        super.configureUI()
        titleLbl.text = FAVORITES.localized()
        productAndShopSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: Constants.font.rawValue, size: 17)], for: .normal)
        productAndShopSegment.setTitle(PRODUCTS.localized(), forSegmentAt: 0)
        productAndShopSegment.setTitle(SHOPS.localized(), forSegmentAt: 1)
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
        
        productAndShopSegment.selectedSegmentIndex = 0
        //viewModel.input.items.onNext(items2 ?? [])
        
        itemsCollectionView.rx.itemSelected.subscribe {[unowned self] (event) in
            guard let indexPath = event.element else { return }
            self.didSelectItemIn(indexPath: indexPath)
        }.disposed(by: bag)
        
        productAndShopSegment.rx
            .controlEvent(.valueChanged)
            .subscribe {[unowned self] (_) in
                self.callFavoritesAPI()
        }.disposed(by: bag)
    }
    
    func callFavoritesAPI(){
        if self.productAndShopSegment.selectedSegmentIndex == 0 {
            self.viewModel.getFavoriteProducts()
        } else {
            self.viewModel.getFavoriteStores()
        }
    }
    
    override func configureData() {
        super.configureData()
        viewModel.output.items.bind(onNext: { (items) in
            if items.count == 0 {
                self.itemsCollectionView.isHidden = true
            } else {
                self.itemsCollectionView.isHidden = false
                self.refreshControl.endRefreshing()
                self.indicator.stopAnimating()
            }
        }).disposed(by: bag)
    }
    
    func registerCell(){
        let nib = UINib(nibName: "ItemsCell", bundle: .main)
        itemsCollectionView.register(nib, forCellWithReuseIdentifier: "ItemsCell")
    }
    
    func changeItemOverBid(){
//        items2?.enumerated().forEach({[unowned self] (element) in
//            if self.isAuction ?? false {
//                var item = element.element
//                item.overbid = LAST_OVERBID.localized()
//                self.items2?[element.offset] = item
//            }
//        })
    }
    
    func configureCategoryCollection(){
        
        itemsCollectionView.delegate = nil
        itemsCollectionView.dataSource = nil
        
        let flowLayout = UICollectionViewFlowLayout()
        let width = (AppUtility.shared.screenWidth - CGFloat(10)) / CGFloat(2)
        flowLayout.itemSize = CGSize(width: width, height: 286)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 5
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
        
        itemsCollectionView.delegate = nil
        itemsCollectionView.dataSource = nil
        
        viewModel.output
            .stores
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
            NavigationCoordinator.shared.mainNavigator.navigate(To: .auctionDetailsViewController(0))
            return
        }
        NavigationCoordinator.shared.mainNavigator.navigate(To: .itemDetailsViewController(0))
    }
    
    
    @objc func refreshTableView(){
        viewModel.pageNum = 1
        callFavoritesAPI()
    }
    
    func loadNewPage(){
        indicator.startAnimating()
        callFavoritesAPI()
        itemsCollectionView.scrollToItem(at: IndexPath(row: viewModel.pastLastIndex, section: 0), at: .bottom, animated: false)
    }

}
