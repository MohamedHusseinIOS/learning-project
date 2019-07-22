//
//  AddressesViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/22/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit

class AddressesViewController: BaseViewController {

    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addressesTableView: UITableView!
    
    let viewModel = AddressesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let data = [["m": 1],
                    ["m": 1]]
        viewModel.input.addresses.onNext(data)
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
    }
    
    func registerCell(){
        let nib = UINib(nibName: "AddressCell", bundle: .main)
        addressesTableView.register(nib, forCellReuseIdentifier: "AddressCell")
    }
    
    func configureTableView(){
        addressesTableView.delegate = nil
        addressesTableView.dataSource = nil
        
        viewModel.output.addresses.bind(to: addressesTableView.rx.items) { tableView, row, element in
            let indexPath = IndexPath(row: row, section: 0)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as? AddressCell else { return AddressCell() }
            cell.bindOnData(element)
            cell.deleteAction = {[unowned self] in
                self.deleteBtnTapped(in: indexPath)
            }
            return cell
        }.disposed(by: bag)
        
        addressesTableView.rx
            .itemSelected
            .bind {[unowned self] (indexPath) in
                self.selectedCellAt(indexPath)
        }.disposed(by: bag)
        
        backBtn.rx
            .tap
            .bind {[unowned self] (_) in
                self.navigationController?.popViewController(animated: true)
        }.disposed(by: bag)
    }
    
    
    func selectedCellAt(_ indexPath: IndexPath){
        //Code
    }
    
    func deleteBtnTapped(in index: IndexPath){
        if #available(iOS 11.0, *) {
            addressesTableView.performBatchUpdates({ [unowned self] in
                self.deleteRow(at: index)
            }, completion: nil)
        } else {
            addressesTableView.beginUpdates()
            deleteRow(at: index)
            addressesTableView.endUpdates()
        }
        addressesTableView.reloadData()
    }
    
    func deleteRow(at index: IndexPath) {
        viewModel.removeItem(at: index)
        if AppUtility.shared.currentLang == .ar {
            addressesTableView.deleteRows(at: [index], with: .right)
        } else {
            addressesTableView.deleteRows(at: [index], with: .left)
        }
    }

}
