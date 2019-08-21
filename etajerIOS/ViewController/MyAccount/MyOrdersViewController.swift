//
//  MyOrderViewController.swift
//  etajerIOS
//
//  Created by mohamed on 8/21/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxCocoa

class MyOrdersViewController: BaseViewController {

    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var ordersTableView: UITableView!
    
    let viewModel = MyOrdersViewModel()
    let refreshControl = UIRefreshControl()
    let indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        ordersTableView.addSubview(refreshControl)
        viewModel.getMyOrders()
    }
    
    override func configureUI() {
        super.configureUI()
        registerCell()
        configureTableView()
        
        backBtn.rx
            .tap
            .subscribe {[unowned self] (_) in
                self.navigationController?.popViewController(animated: true)
        }.disposed(by: bag)
    }
    
    override func configureData() {
        super.configureData()
        
        viewModel.output.myOrders.bind { [unowned self] (orders) in
            if orders.count == 0 {
                self.ordersTableView.isHidden = true
            } else {
                self.ordersTableView.isHidden = false
                self.refreshControl.endRefreshing()
                self.indicator.stopAnimating()
            }
        }.disposed(by: bag)
        
        viewModel.output
            .failure
            .bind { (errors) in
                guard let error = errors.first, let msg = error.message else { return }
                self.alert(title: "", message: msg, completion: nil)
        }.disposed(by: bag)
    }
    
    func registerCell(){
        let nib = UINib(nibName: CartCell.reuseId, bundle: .main)
        ordersTableView.register(nib, forCellReuseIdentifier: CartCell.reuseId)
    }
    
    func configureTableView() {
        ordersTableView.tableFooterView = indicator
        viewModel.output
            .myOrders
            .bind(to: ordersTableView.rx.items) { [weak self] tableView, row, item in
                guard let self = self else { return CartCell() }
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseId, for: indexPath) as? CartCell else { return CartCell()}
                if (row == (self.viewModel.orders.count - 1 )) {
                    self.loadNewPage()
                }
                return cell
        }.disposed(by: bag)
    }

    @objc func refreshTableView(){
        viewModel.pageNum = 1
        viewModel.getMyOrders()
    }
    
    func loadNewPage(){
        indicator.startAnimating()
        viewModel.getMyOrders()
        ordersTableView.scrollToRow(at: IndexPath(row: viewModel.pastLastIndex, section: 0), at: .bottom, animated: false)
    }
    
}
