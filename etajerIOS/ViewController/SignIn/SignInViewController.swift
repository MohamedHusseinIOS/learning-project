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
        KeyboardAvoiding.avoidingView = self.view
        
        emailTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: viewModel.dispose)
        
        passwordTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: viewModel.dispose)
        
        signInBtn.rx
            .tap
            .subscribe { (_) in
            
            }.disposed(by: viewModel.dispose)
        
        forgetPasswordBtn.rx
            .tap
            .subscribe { (_) in
                
            }.disposed(by: viewModel.dispose)
        
        registerBtn.rx
            .tap
            .subscribe { (_) in
                NavigationCoordinator.shared.mainNavigator.navigate(To: .signUpViewController)
            }.disposed(by: viewModel.dispose)
        
    }

}
