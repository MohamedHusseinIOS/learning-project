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
    
    let viewModel = CategoryItemsViewModel()
    var items: [Item]?
    var items2: [Item]? = [Item(name: "شاشة سامسونج",
                               price: "3000 ر.س",
                               image: #imageLiteral(resourceName: "screen"),
                               rating: 3,
                               overbid: ""),
                          Item(name: "لكرس إى اس 350",
                               price: "45000 ر.س",
                               image: #imageLiteral(resourceName: "lexus"),
                               rating: 5,
                               overbid: ""),
                          Item(name: "لكرس إى اس 350",
                               price: "45000 ر.س",
                               image: #imageLiteral(resourceName: "lexus"),
                               rating: 5,
                               overbid: ""),
                          Item(name: "شاشة سامسونج",
                               price: "3000 ر.س",
                               image: #imageLiteral(resourceName: "screen"),
                               rating: 3,
                               overbid: ""),
                          Item(name: "لكرس إى اس 350",
                               price: "45000 ر.س",
                               image: #imageLiteral(resourceName: "lexus"),
                               rating: 5,
                               overbid: ""),
                          Item(name: "لكرس إى اس 350",
                               price: "45000 ر.س",
                               image: #imageLiteral(resourceName: "lexus"),
                               rating: 5,
                               overbid: ""),
                          Item(name: "شاشة سامسونج",
                               price: "3000 ر.س",
                               image: #imageLiteral(resourceName: "screen"),
                               rating: 3,
                               overbid: ""),
                          Item(name: "لكرس إى اس 350",
                               price: "45000 ر.س",
                               image: #imageLiteral(resourceName: "lexus"),
                               rating: 5,
                               overbid: ""),
                          Item(name: "لكرس إى اس 350",
                               price: "45000 ر.س",
                               image: #imageLiteral(resourceName: "lexus"),
                               rating: 5,
                               overbid: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureUI() {
        super.configureUI()
        titleLbl.text = title
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
    }
    
    func registerCell(){
        let nib = UINib(nibName: "ItemsCell", bundle: .main)
        itemsCollectionView.register(nib, forCellWithReuseIdentifier: "ItemsCell")
    }
    
    func configureCategoryCollection(){
        
        itemsCollectionView.delegate = nil
        itemsCollectionView.dataSource = nil
        
        let flowLayout = UICollectionViewFlowLayout()
        let width = (itemsCollectionView.frame.size.width - CGFloat(10)) / CGFloat(2.0)
        flowLayout.itemSize = CGSize(width: width, height: 266)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 0
        
        itemsCollectionView.setCollectionViewLayout(flowLayout, animated: true)
        itemsCollectionView.scrollsToTop = true
        viewModel.output
            .items
            .bind(to: itemsCollectionView.rx.items){ collectionView, item, element in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsCell", for: IndexPath(item: item, section: 0)) as? ItemsCell else { return ItemsCell() }
                cell.bindOn(item: element)
                cell.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                return cell
            }.disposed(by: bag)
        
        itemsCollectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }

}
