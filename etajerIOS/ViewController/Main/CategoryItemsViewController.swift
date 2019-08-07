//
//  CategoryItemsViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/14/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxCocoa
import SkeletonView

class CategoryItemsViewController: BaseViewController {

    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    @IBOutlet weak var filterBtn: UIButton!
    
    var category: Category?
    let viewModel = CategoryItemsViewModel()
    var filterDict = [String: Bool]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = category?.id else { return }
        viewModel.getProducts(parent: self, categoryId: id)
    }
    
    override func configureUI() {
        super.configureUI()
        titleLbl.text = title
        registerCell()
        configureItemsCollection()
        itemsCollectionView.dataSource = self
        itemsCollectionView.showAnimatedGradientSkeleton()
        
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
        
        filterBtn.rx.tap.bind { (_) in
            NavigationCoordinator.shared.mainNavigator.present(.filterViewController({[weak self] (filterDict) in
                guard let self = self else { return }
                self.filterData(by: filterDict)
            }, self.category, self.filterDict), completion: nil)
        }.disposed(by: bag)
        
        itemsCollectionView.rx
            .itemSelected
            .subscribe {[unowned self] (event) in
                guard let indexPath = event.element else { return }
                self.didSelectItemIn(indexPath: indexPath)
        }.disposed(by: bag)
        
        viewModel.output.products.bind {[unowned self] (products) in
            self.itemsCollectionView.hideSkeleton()
        }.disposed(by: bag)
    }
    
    func registerCell(){
        let nib = UINib(nibName: "ItemsCell", bundle: .main)
        itemsCollectionView.register(nib, forCellWithReuseIdentifier: "ItemsCell")
    }
    
    func configureItemsCollection(){
        
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
            .products
            .bind(to: itemsCollectionView.rx.items){ collectionView, item, element in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsCell", for: IndexPath(item: item, section: 0)) as? ItemsCell else { return ItemsCell() }
                cell.bindOn(item: element)
                cell.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                return cell
            }.disposed(by: bag)
        
        itemsCollectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    func didSelectItemIn(indexPath: IndexPath){
        let product = viewModel.productsArr[indexPath.item]
        guard let id = product.id else { return }
        
        if product.auctionPrice != nil {
            NavigationCoordinator.shared.mainNavigator.navigate(To: .auctionDetailsViewController(id))
        } else {
            NavigationCoordinator.shared.mainNavigator.navigate(To: .itemDetailsViewController(id))
        }
    }
    
    func filterData(by dict: [String: Bool]){
        self.filterDict = dict
        let products = viewModel.allProducts
        var filteredData = [Product]()
        var filteredSubCategoriesData = [Product]()
        
        for filterBy in dict where filterBy.value == true {
            let name = filterBy.key
            switch name {
            case PRODUCTS.localized():
                let filtered = products.filter({ $0.auctionPrice == nil })
                filteredData.append(contentsOf: filtered)
            case CATEGORY_TITLE_2.localized():
                let filtered = products.filter({ $0.auctionPrice != nil })
                filteredData.append(contentsOf: filtered)
            case NEW.localized():
                continue
            case USED.localized():
                continue
            default:
                let subCategories = category?.childs
                let subCategory = subCategories?.filter({ $0.name == name }).first
                if filteredData.count == 0 {
                    let filtered = products.filter { (product) in
                        return subCategory?.childs?.contains(where: {$0.id == product.categoryId}) ?? false
                    }
                    filteredSubCategoriesData.append(contentsOf: filtered)
                } else {
                    let filtered = filteredData.filter { (product) in
                        return subCategory?.childs?.contains(where: {$0.id == product.categoryId}) ?? false
                    }
                    filteredSubCategoriesData.append(contentsOf: filtered)
                }
            }
        }
        
        if filteredSubCategoriesData.count > 0 {
            viewModel.input.products.onNext(filteredSubCategoriesData)
        } else {
            viewModel.input.products.onNext(filteredData)
        }
    }
}

extension CategoryItemsViewController: SkeletonCollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsCell", for: indexPath)
        return cell
    }
    
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "ItemsCell"
    }
}
