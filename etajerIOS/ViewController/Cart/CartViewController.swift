//
//  CartViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/22/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CartViewController: BaseViewController {

    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var itemsTableView: UITableView!
    
    let viewModel = CartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let items = [Item(name: nil, price: nil, image: nil, images: nil, rating: nil, overbid: nil),
                     Item(name: nil, price: nil, image: nil, images: nil, rating: nil, overbid: nil),
                     Item(name: nil, price: nil, image: nil, images: nil, rating: nil, overbid: nil),
                     Item(name: nil, price: nil, image: nil, images: nil, rating: nil, overbid: nil)]
        
        viewModel.input.items.onNext(items)
        
    }
    
    override func configureUI() {
        super.configureUI()
        
        if AppUtility.shared.currentLang == .ar {
            backImg.image = #imageLiteral(resourceName: "white-back-ar")
        } else {
            backImg.image = #imageLiteral(resourceName: "white-back-en")
        }
        
        registerCell()
        configureTableView()
        
        backBtn.rx.tap.bind { [unowned self](_) in
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: bag)
    }
    
    func registerCell(){
        let nib = UINib(nibName: "CartCell", bundle: .main)
        itemsTableView.register(nib, forCellReuseIdentifier: "CartCell")
    }
    
    func configureTableView(){
        let headerView = CartHeaderView.instanceFromNib() as? CartHeaderView
        itemsTableView.tableHeaderView = headerView
        
        viewModel.output
            .items
            .bind(to: itemsTableView.rx.items){ tabelView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tabelView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell else { return CartCell() }
                cell.bindOnData(element)
                cell.deleteAction = {[unowned self] in
                    self.deleteBtnTapped(in: indexPath)
                }
                return cell
        }.disposed(by: bag)
    }
    
    func deleteBtnTapped(in index: IndexPath){
        if #available(iOS 11.0, *) {
            itemsTableView.performBatchUpdates({ [unowned self] in
                self.deleteRow(at: index)
                }, completion: nil)
        } else {
            itemsTableView.beginUpdates()
            deleteRow(at: index)
            itemsTableView.endUpdates()
        }
        itemsTableView.reloadData()
    }
    
    func deleteRow(at index: IndexPath) {
        viewModel.removeItem(at: index)
        if AppUtility.shared.currentLang == .ar {
            itemsTableView.deleteRows(at: [index], with: .right)
        } else {
            itemsTableView.deleteRows(at: [index], with: .left)
        }
    }

}
