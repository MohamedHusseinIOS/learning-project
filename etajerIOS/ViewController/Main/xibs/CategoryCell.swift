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
    @IBOutlet weak var moreBtn: UIButton!
    
    var categoryItems = BehaviorSubject<[Item]>(value: [])
    let bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerCell()
        configureCategoryCollection()
        moreBtn.tintColor = #colorLiteral(red: 0.7112585902, green: 0.3965147138, blue: 0.627440989, alpha: 1)
        moreBtn.imageView?.contentMode = .scaleAspectFit
        if AppUtility.shared.currentLang == .ar{
            moreBtn.setImage(#imageLiteral(resourceName: "back-en"), for: .normal)
        } else {
            moreBtn.setImage(#imageLiteral(resourceName: "back-ar"), for: .normal)
        }
    }
    
    func registerCell(){
        let nib = UINib(nibName: "ItemsCell", bundle: .main)
        categoryCollectionView.register(nib, forCellWithReuseIdentifier: "ItemsCell")
    }
    
    func configureCategoryCollection(){
        categoryCollectionView.delegate = nil
        categoryCollectionView.dataSource = nil
        
        let flowLayout = UICollectionViewFlowLayout()
        let width = (categoryCollectionView.frame.size.width - CGFloat(10)) / CGFloat(2)
        flowLayout.itemSize = CGSize(width: width, height: 266)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        categoryCollectionView.setCollectionViewLayout(flowLayout, animated: true)
        
        categoryItems.bind(to: categoryCollectionView.rx.items){ collectionView, item, element in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsCell", for: IndexPath(item: item, section: 0)) as? ItemsCell else { return ItemsCell() }
            cell.bindOn(item: element)
            return cell
        }.disposed(by: bag)
        
    }

}
