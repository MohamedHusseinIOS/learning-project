//
//  HomeViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/8/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxCocoa

class HomeViewController: BaseViewController {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var changeLang: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureUI() {
        super.configureUI()
        
        changeLang.setTitle(CHANGE_LANG.localized(), for: .normal)
        
        menuBtn.rx
            .tap
            .subscribe {[unowned self] (_) in
                self.openMenu()
            }.disposed(by: bag)
        
        changeLang.rx
            .tap
            .subscribe { (_) in
                AppUtility.shared.changeLanguage()
        }.disposed(by: bag)
    }
    
    

}
