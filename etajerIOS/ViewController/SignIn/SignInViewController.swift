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
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //code
    }
    
    override func configureUI() {
        super.configureUI()
        KeyboardAvoiding.avoidingView = self.passwordTxt
        
        emailTxt.placeholder = EMAIL.localized()
        passwordTxt.placeholder = PASSWORD.localized()
        
        var registerBtnTitle = DONT_HAVE_ACCOUNT.localized()
        let singupNow = SIGNUP_NOW.localized()
        registerBtnTitle.append(singupNow)
        registerBtn.setTitle(registerBtnTitle, for: .normal)
        
        emailTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.input.email)
            .disposed(by: disposeBag)
        
        passwordTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.input.password)
            .disposed(by: disposeBag)
        
        viewModel.output.success.subscribe { (event) in
            guard let isSuccess = event.element else {return}
            print(isSuccess)
        }.disposed(by: disposeBag)
        
        signInBtn.rx
            .tap
            .subscribe { (_) in
                NavigationCoordinator.shared.sideMenuSetup()
            }.disposed(by: disposeBag)
        
        forgetPasswordBtn.rx
            .tap
            .subscribe { (_) in
                NavigationCoordinator.shared.mainNavigator.navigate(To: .forgetPasswordViewController)
            }.disposed(by: disposeBag)
        
        registerBtn.rx
            .tap
            .subscribe { (_) in
                NavigationCoordinator.shared.mainNavigator.navigate(To: .signUpViewController)
            }.disposed(by: disposeBag)
        
    }

}
