//
//  AddressesViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/22/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import SkeletonView

class AddressesViewController: BaseViewController {

    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addressesTableView: UITableView!
    
    let viewModel = AddressesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getAddresses(parent: self)
    }
    
    override func configureUI() {
        super.configureUI()
        registerCell()
        addressesTableView.dataSource = self
        addressesTableView.showAnimatedGradientSkeleton()
        
        if AppUtility.shared.currentLang == .ar {
            backImg.image = #imageLiteral(resourceName: "white-back-ar")
        } else {
            backImg.image = #imageLiteral(resourceName: "white-back-en")
        }
        
        backBtn.rx
            .tap
            .bind {[unowned self] (_) in
                self.navigationController?.popViewController(animated: true)
        }.disposed(by: bag)
    }
    
    func registerCell(){
        let nib = UINib(nibName: "AddressCell", bundle: .main)
        addressesTableView.register(nib, forCellReuseIdentifier: "AddressCell")
    }
    
    func configureTableView(){
        addressesTableView.delegate = nil
        addressesTableView.dataSource = nil
        
        viewModel.output.addresses.bind(to: addressesTableView.rx.items) { tableView, row, element in
            tableView.hideSkeleton()
            let indexPath = IndexPath(row: row, section: 0)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as? AddressCell else { return AddressCell() }
            cell.bindOnData(element)
            cell.deleteAction = {[unowned self] in
                self.deleteBtnTapped(in: indexPath)
            }
            cell.editAddress = {
                //Code
            }
            return cell
        }.disposed(by: bag)
        
        addressesTableView.rx
            .itemSelected
            .bind {[unowned self] (indexPath) in
                self.selectedCellAt(indexPath)
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

extension AddressesViewController: SkeletonTableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as? AddressCell
        cell?.activeSkeleton()
        return cell ?? UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "AddressCell"
    }
}
