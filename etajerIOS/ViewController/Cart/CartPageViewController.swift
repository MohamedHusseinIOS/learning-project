//
//  CartPageViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/24/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CartPageViewController: BaseViewController {

    @IBOutlet weak var itemsTableView: UITableView!

    let viewModel = CartPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCartItems()
    }
    
    override func configureUI() {
        super.configureUI()
        
        registerCell()
        configureTableView()
    }
    
    override func configureData() {
        super.configureData()
        
    }

    func registerCell(){
        let nib = UINib(nibName: "CartCell", bundle: .main)
        itemsTableView.register(nib, forCellReuseIdentifier: "CartCell")
        
        let enterCodeNib = UINib(nibName: "EnterCodeCell", bundle: .main)
        itemsTableView.register(enterCodeNib, forCellReuseIdentifier: "EnterCodeCell")
    }
    
    func configureTableView(){
        viewModel.output
            .items
            .bind(to: itemsTableView.rx.items){[unowned self] tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                if row == (self.viewModel.dataArray.count - 1) {
                    let cell = self.dequeueEnterCodeCell(tableView: tableView, indexPath: indexPath)
                    return cell
                } else {
                    let cell = self.dequeueCartCell(tableView: tableView, indexPath: indexPath, data: element)
                    return cell
                }
            }.disposed(by: bag)
    }
    
    func dequeueCartCell(tableView: UITableView, indexPath: IndexPath, data:
        CartProduct) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell else { return CartCell() }
        cell.bindOnData(data)
        cell.deleteAction = {[unowned self] in
            guard let id = data.id else { return }
            self.viewModel.removeProductFormCart(productId: id)
        }
        return cell
    }
    
    func dequeueEnterCodeCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EnterCodeCell", for: indexPath) as? EnterCodeCell else { return EnterCodeCell() }
        return cell
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
        if AppUtility.shared.currentLang == .ar {
            itemsTableView.deleteRows(at: [index], with: .right)
        } else {
            itemsTableView.deleteRows(at: [index], with: .left)
        }
    }
    
}
