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

class SignInViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
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
            .subscribe {[unowned self] (_) in
                self.login()
            }.disposed(by: disposeBag)
        
        forgetPasswordBtn.rx
            .tap
            .subscribe { (_) in
                NavigationCoordinator.shared.mainNavigator.navigate(To: .forgetPasswordViewController)
            }.disposed(by: disposeBag)
        
        registerBtn.rx
            .tap
            .subscribe { (_) in
                self.registerBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.registerBtn.borderColor = #colorLiteral(red: 0.2761612535, green: 0.1481507123, blue: 0.3897372484, alpha: 1)
                self.registerBtn.borderWidth = 1
                NavigationCoordinator.shared.mainNavigator.navigate(To: .signUpViewController)
            }.disposed(by: disposeBag)
        
        closeBtn.rx.tap.bind {[unowned self] (_) in
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: bag)
    }
    
    override func configureData() {
        super.configureData()
        
        viewModel.output.success.bind {[unowned self] (success) in
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: bag)
        
        viewModel.output.failer.bind { (errorArr) in
            let error = errorArr.first
            guard let msg = error?.message else { return }
            self.alert(title: "", message: msg, completion: nil)
        }.disposed(by: bag)
    }
    
    func login(){
        guard let emailText = emailTxt.text?.trimmingCharacters(in: .whitespaces), emailText.count != 0 , emailText.isValidEmail() else {
            self.alert(title: "email", message: "please, enter valid email", completion: nil)
            return
        }
        guard let passwordText = passwordTxt.text?.trimmingCharacters(in: .whitespaces), passwordText.count != 0 else {
            self.alert(title: "password", message: "please, enter password", completion: nil)
            return
        }
        viewModel.signIn(email: emailText, password: passwordText)
    }

}
