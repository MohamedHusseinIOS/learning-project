//
//  ForgetPasswordViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/7/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxSwift
import IHKeyboardAvoiding

class ForgetPasswordViewController: BaseViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    var viewModel = ForgetPasswordViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureUI() {
        super.configureUI()
        
        KeyboardAvoiding.avoidingView = self.view
        
        emailTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: bag)
        
        sendBtn.rx
            .tap
            .subscribe { (_) in
                //Code
        }.disposed(by: bag)
    }

}
