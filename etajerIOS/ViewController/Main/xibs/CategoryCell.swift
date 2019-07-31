//
//  CategoryCell.swift
//  etajerIOS
//
//  Created by mohamed on 7/9/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryNameLbl: UILabel!
    @IBOutlet weak var moreItemsLbl: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var moreBtnImg: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    
    var categoryItems = BehaviorSubject<[Product]>(value: [])
    var parent: HomeViewController?
    let bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerCell()
        configureCategoryCollection()
        moreBtn.tintColor = #colorLiteral(red: 0.7112585902, green: 0.3965147138, blue: 0.627440989, alpha: 1)
        moreBtn.imageView?.contentMode = .scaleAspectFit
        if AppUtility.shared.currentLang == .ar{
            moreBtnImg.setImage(#imageLiteral(resourceName: "back-en"), for: .normal)
        } else {
            moreBtnImg.setImage(#imageLiteral(resourceName: "back-ar"), for: .normal)
        }
        moreBtn.rx
            .tap
            .subscribe {[unowned self] (_) in
                guard let title = self.categoryNameLbl.text else { return }
                let isAuction = title == CATEGORY_TITLE_2.localized()
                NavigationCoordinator.shared.mainNavigator.navigate(To: .categoryItemsViewController(title, isAuction))
        }.disposed(by: bag)
    }
    
    func registerCell(){
        let nib = UINib(nibName: "ItemsCell", bundle: .main)
        categoryCollectionView.register(nib, forCellWithReuseIdentifier: "ItemsCell")
    }
    
    func configureCategoryCollection(){
        categoryCollectionView.delegate = nil
        categoryCollectionView.dataSource = nil
        
        let flowLayout = UICollectionViewFlowLayout()
        let width = (categoryCollectionView.frame.size.width - CGFloat(10)) / CGFloat(2.3)
        flowLayout.itemSize = CGSize(width: width, height: 266)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        categoryCollectionView.setCollectionViewLayout(flowLayout, animated: true)
        categoryCollectionView.scrollsToTop = true
        categoryItems.bind(to: categoryCollectionView.rx.items){ collectionView, item, element in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsCell", for: IndexPath(item: item, section: 0)) as? ItemsCell else { return ItemsCell() }
            cell.bindOn(item: element)
            cell.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            return cell
        }.disposed(by: bag)
        
        categoryCollectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        categoryCollectionView.rx.itemSelected.subscribe { (event) in
            if self.categoryNameLbl.text! == CATEGORY_TITLE_2.localized() {
                NavigationCoordinator.shared.mainNavigator.navigate(To: .auctionDetailsViewController)
            }else{
                NavigationCoordinator.shared.mainNavigator.navigate(To: .itemDetailsViewController)
            }
        }.disposed(by: bag)
    }

}
