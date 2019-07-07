//
//  SignInViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/4/19.
//  Copyright © 2019 mohamed ismail. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import IHKeyboardAvoiding

class SignInViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    let viewModel = SignInViewModel()
    var email: String?
    var password: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //code
    }
    
    override func configureUI() {
        super.configureUI()
        KeyboardAvoiding.avoidingView = self.passwordTxt
        
        let registerBtnTitle = "ليس لديك حساب؟".attributedString(fontSize: 17, color: #colorLiteral(red: 0.2745098039, green: 0.1490196078, blue: 0.3882352941, alpha: 1))
        let singupNow = "سجل الان".attributedString(fontSize: 17, color: #colorLiteral(red: 0.9215686275, green: 0.3333333333, blue: 0.3568627451, alpha: 1))
        registerBtnTitle.append(singupNow)
        
        registerBtn.setAttributedTitle(registerBtnTitle, for: .normal)
        
        emailTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: bag)
        
        passwordTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: bag)
        
        signInBtn.rx
            .tap
            .subscribe { (_) in
                NavigationCoordinator.shared.sideMenuSetup()
            }.disposed(by: bag)
        
        forgetPasswordBtn.rx
            .tap
            .subscribe { (_) in
                NavigationCoordinator.shared.mainNavigator.navigate(To: .forgetPasswordViewController)
            }.disposed(by: bag)
        
        registerBtn.rx
            .tap
            .subscribe { (_) in
                NavigationCoordinator.shared.mainNavigator.navigate(To: .signUpViewController)
            }.disposed(by: bag)
        
    }

}
