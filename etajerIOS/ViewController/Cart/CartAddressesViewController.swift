//
//  CartAddressesViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/24/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CartAddressesViewController: BaseViewController {

    @IBOutlet weak var addressTableView: UITableView!
    
    let viewModel = CartAddressesViewModel()
    var dataCallback: (([Address])->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAddresses()
    }
    
    override func configureUI() {
        super.configureUI()
        
        registerCell()
        configureTableView()
    }
    
    override func configureData() {
        super.configureData()
            
        viewModel.output
            .faliure
            .bind {[unowned self] (errors) in
                self.alert(title: "", message: errors.first?.message ?? "", completion: nil)
            }.disposed(by: bag)
        
        viewModel.output.addresses.bind {[unowned self] (addresses) in
            var dataArr = addresses
            dataArr.removeLast()
            self.dataCallback?(dataArr)
        }.disposed(by: bag)
    }
    
    func registerCell(){
        let nib = UINib(nibName: "CartAddressCell", bundle: .main)
        addressTableView.register(nib, forCellReuseIdentifier: "CartAddressCell")
        
        let addAddressNib = UINib(nibName: "AddAddressCell", bundle: .main)
        addressTableView.register(addAddressNib, forCellReuseIdentifier: "AddAddressCell")
    }
    
    func configureTableView(){
        addressTableView.delegate = nil
        addressTableView.dataSource = nil
        
        viewModel.output
            .addresses
            .bind(to: addressTableView.rx.items) {[unowned self] tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                if row == (self.viewModel.dataArray.count - 1) {
                    let cell = self.dequeueAddAddressCell(tableView: tableView, indexPath: indexPath, data: nil)
                    return cell
                } else {
                    let cell = self.dequeueAddressCell(tableView: tableView, indexPath: indexPath, data: element)
                    return cell
                }
        }.disposed(by: bag)
        
        addressTableView.rx
            .itemSelected
            .bind {[unowned self] (indexPath) in
                self.selectedCellAt(indexPath)
        }.disposed(by: bag)
    }
    
    func selectedCellAt(_ indexPath: IndexPath){
        //Code
    }
    
    func dequeueAddAddressCell(tableView: UITableView, indexPath: IndexPath, data: Address?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddAddressCell", for: indexPath) as? AddAddressCell else { return AddAddressCell() }
        cell.setup()
        return cell
    }
    
    func dequeueAddressCell(tableView: UITableView, indexPath: IndexPath, data: Address) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartAddressCell", for: indexPath) as? CartAddressCell else { return CartAddressCell() }
        cell.bindOnData(data)
        cell.deleteAction = { [weak self] in
            guard let self = self else { return }
            self.deleteBtnTapped(in: indexPath)
        }
        return cell
    }
    
    func deleteBtnTapped(in index: IndexPath){
        if #available(iOS 11.0, *) {
            addressTableView.performBatchUpdates({ [unowned self] in
                self.deleteRow(at: index)
             }, completion: nil)
        } else {
            addressTableView.beginUpdates()
            deleteRow(at: index)
            addressTableView.endUpdates()
        }
        addressTableView.reloadData()
    }
    
    func deleteRow(at index: IndexPath) {
        viewModel.removeItem(at: index)
        if AppUtility.shared.currentLang == .ar {
            addressTableView.deleteRows(at: [index], with: .right)
        } else {
            addressTableView.deleteRows(at: [index], with: .left)
        }
    }
}
