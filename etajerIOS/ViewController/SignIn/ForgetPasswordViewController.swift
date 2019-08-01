//
//  ForgetPasswordViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/7/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxSwift

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
            .subscribe {[unowned self] (_) in
                self.requestResetPassword()
        }.disposed(by: bag)
    }
    
    override func configureData() {
        viewModel.successMsg.bind {[unowned self] (successMsg) in
            self.alert(title: "", message: successMsg, completion: {
                NavigationCoordinator.shared.mainNavigator.popViewController(to: .signInViewController)
            })
        }.disposed(by: bag)
        
        viewModel.failer.bind { (errorArr) in
            let error = errorArr.first
            guard let msg = error?.message else { return }
            self.alert(title: "", message: msg, completion: nil)
        }.disposed(by: bag)
    }
    
    func requestResetPassword(){
        
        guard let emailText = emailTxt.text?.trimmingCharacters(in: .whitespaces), emailText.count != 0 , emailText.isValidEmail() else {
            self.alert(title: "email", message: "please, enter valid email", completion: nil)
            return
        }
        viewModel.requestResetPassword(email: emailText)
    }

}
