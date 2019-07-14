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

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var forgetPasswordLbl: UILabel!
    @IBOutlet weak var setEmailLbl: UILabel!
    
    
    var viewModel = ForgetPasswordViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureUI() {
        super.configureUI()
        
        KeyboardAvoiding.avoidingView = self.view
        backBtn.addTarget(self, action: #selector(backBtnTapped(_:)), for: .touchUpInside)
        if AppUtility.shared.currentLang == .ar{
            backBtn.setImage(#imageLiteral(resourceName: "back-en"), for: .normal)
        } else {
            backBtn.setImage(#imageLiteral(resourceName: "back-ar"), for: .normal)
        }
        
        emailTxt.placeholder = ENTER_YOUR_EMAIL.localized()
        
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
