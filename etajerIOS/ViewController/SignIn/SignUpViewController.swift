//
//  SignUpViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/4/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class SignUpViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var mobileTxt: UITextField!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var familyNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var txtViewsStackView: UIStackView!
    @IBOutlet weak var termsAndConditionsTxt: UITextView!
    @IBOutlet weak var haveAccSignInBtn: UIButton!
    
    let viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureUI() {
        super.configureUI()
        
        termsAndConditionsTxt.attributedText = addLinkToText()
        termsAndConditionsTxt.textAlignment = .center
        termsAndConditionsTxt.linkTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.Rose.value]
        
        let haveAccSignInBtnTitle = "لديك حساب؟".attributedString(fontSize: 17, color: #colorLiteral(red: 0.2745098039, green: 0.1490196078, blue: 0.3882352941, alpha: 1))
        let singupNow = "سجل دخول".attributedString(fontSize: 17, color: #colorLiteral(red: 0.9215686275, green: 0.3333333333, blue: 0.3568627451, alpha: 1))
        haveAccSignInBtnTitle.append(singupNow)
        haveAccSignInBtn.setAttributedTitle(haveAccSignInBtnTitle, for: .normal)
        
        passwordTxt.rx
            .controlEvent(.editingDidBegin)
            .asObservable()
            .subscribe { (_) in
            self.avoidKeyboard()
        }.disposed(by: bag)
        bindValuesToViewModel()
    }
    
    func bindValuesToViewModel(){
        emailTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: bag)
        mobileTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.mobile)
            .disposed(by: bag)
        firstNameTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.firstName)
            .disposed(by: bag)
        familyNameTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.familyName)
            .disposed(by: bag)
        passwordTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: bag)
        confirmPasswordTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.confirmPassword)
            .disposed(by: bag)
    }
    
    func addLinkToText() -> NSMutableAttributedString{
        let string = "بالضغط على زر تسجيل حساب جديد، فإنك توافق علي".attributedString()
        let firstLink = " الشروط والاحكام ".clickableString(gotolink: "https://etajer.maxsys.sa/")
        let and = " و ".attributedString()
        let secondLink = " سياسةالخصوصية ".clickableString(gotolink: "https://etajer.maxsys.sa/")
        
        string.append(firstLink)
        string.append(and)
        string.append(secondLink)
        
        return string
    }
    
    func avoidKeyboard(){
        let rect = CGRect(origin: CGPoint(x: 0, y: self.haveAccSignInBtn.frame.origin.y + 40),
                          size: self.haveAccSignInBtn.frame.size)
        self.scrollView.scrollRectToVisible(rect, animated: true)
    }
    
}
