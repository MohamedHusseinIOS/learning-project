//
//  NotificationViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/21/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class NotificationsViewController: BaseViewController {

    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var notificationsTableView: UITableView!
    
    let viewModel = NotificationViewModel()
    let refreshControl = UIRefreshControl()
    let indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        notificationsTableView.addSubview(refreshControl)
        viewModel.getNotifications()
    }
    
    override func configureUI() {
        super.configureUI()
        
        if AppUtility.shared.currentLang == .ar {
            backImg.image = #imageLiteral(resourceName: "white-back-ar")
        } else {
            backImg.image = #imageLiteral(resourceName: "white-back-en")
        }
        
        registerCell()
        configureTableViwe()
        
        backBtn.rx
            .tap
            .subscribe {[unowned self] (_) in
                self.navigationController?.popViewController(animated: true)
        }.disposed(by: bag)
    }
    
    override func configureData() {
        super.configureData()
        
        viewModel.output
            .notifications
            .bind { [unowned self] (orders) in
                if orders.count == 0 {
                    self.notificationsTableView.isHidden = true
                } else {
                    self.notificationsTableView.isHidden = false
                    self.refreshControl.endRefreshing()
                    self.indicator.stopAnimating()
                }
            }.disposed(by: bag)
        
        viewModel.output
            .faliure
            .bind { (errors) in
                guard let error = errors.first, let msg = error.message else { return }
                self.alert(title: "", message: msg, completion: nil)
            }.disposed(by: bag)
    }
    
    func registerCell(){
        let nib = UINib(nibName: "NotificationCell", bundle: .main)
        notificationsTableView.register(nib, forCellReuseIdentifier: "NotificationCell")
    }
    
    func configureTableViwe(){
        notificationsTableView.delegate = nil
        notificationsTableView.dataSource = nil
        viewModel.output
            .notifications
            .bind(to: notificationsTableView.rx.items) { tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as? NotificationCell else { return NotificationCell() }
                cell.configureUI(buyOffer: true, notificationData: element)
                cell.closeAction = { [weak self] in
                    guard let self = self else { return }
                    //self.closeBtnTapped(in: indexPath)
                }
                if (row == (self.viewModel.notificationsArray.count - 1 )) {
                    self.loadNewPage()
                }
                return cell
        }.disposed(by: bag)
        
        notificationsTableView.rx
            .itemSelected
            .bind { (index) in
                print("[selectedRow]index:\(index)")
        }.disposed(by: bag)
    }
    
//    func closeBtnTapped(in index: IndexPath){
//        if #available(iOS 11.0, *) {
//            notificationsTableView.performBatchUpdates({ [unowned self] in
//                self.deleteRow(at: index)
//            }, completion: nil)
//        } else {
//            notificationsTableView.beginUpdates()
//            deleteRow(at: index)
//            notificationsTableView.endUpdates()
//        }
//        notificationsTableView.reloadData()
//    }
    
    @objc func refreshTableView(){
        viewModel.pageNum = 1
        viewModel.getNotifications()
    }
    
    func loadNewPage(){
        indicator.startAnimating()
        viewModel.getNotifications()
        notificationsTableView.scrollToRow(at: IndexPath(row: viewModel.pastLastIndex, section: 0), at: .bottom, animated: false)
    }
    
//    func deleteRow(at index: IndexPath) {
//        viewModel.removeItem(at: index)
//        if AppUtility.shared.currentLang == .ar {
//            notificationsTableView.deleteRows(at: [index], with: .right)
//        } else {
//            notificationsTableView.deleteRows(at: [index], with: .left)
//        }
//    }
    
}
