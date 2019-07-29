//
//  CartFinishedViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/28/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CartFinishedViewController: BaseViewController {

    
    @IBOutlet weak var orderNumberLbl: UILabel!
    @IBOutlet weak var homeBtn: UIButton!
    
    var orderNumber = "XSJJ45345"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureUI() {
        super.configureUI()
        
        orderNumberLbl.text = "\(ORDER_NUMBER.localized())\(orderNumber)"
        
        homeBtn.rx.tap.bind { (_) in
            NavigationCoordinator.shared.mainNavigator.popViewController(to: .homeViewController)
        }.disposed(by: bag)
    }
    
    
}
