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
    
    var categoryItems: BehaviorSubject<[String]>?
    let bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerCell()
        configureCategoryCollection()
    }
    
    func registerCell(){
        let nib = UINib(nibName: "ItemsCell", bundle: .main)
        categoryCollectionView.register(nib, forCellWithReuseIdentifier: "ItemsCell")
    }
    
    func configureCategoryCollection(){
        categoryCollectionView.delegate = nil
        categoryCollectionView.dataSource = nil
        categoryItems?.bind(to: categoryCollectionView.rx.items){ collectionView, item, element in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsCell", for: IndexPath(item: item, section: 0)) as? ItemsCell else { return ItemsCell() }
            return cell
        }.disposed(by: bag)
    }

}
