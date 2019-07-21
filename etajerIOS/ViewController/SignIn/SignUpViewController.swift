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

    @IBOutlet weak var backBtn: UIButton!
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
    
    @IBOutlet weak var mobileStackView: UIStackView!
    
    
    let viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureUI() {
        super.configureUI()
        backBtn.addTarget(self, action: #selector(backBtnTapped(_:)), for: .touchUpInside)
        
        if AppUtility.shared.currentLang == .ar{
            mobileStackView.addArrangedSubview(mobileStackView.subviews[0])
            backBtn.setImage(#imageLiteral(resourceName: "back-en"), for: .normal)
        } else {
            backBtn.setImage(#imageLiteral(resourceName: "back-ar"), for: .normal)
        }
        termsAndConditionsTxt.attributedText = addLinkToText()
        termsAndConditionsTxt.textAlignment = .center
        termsAndConditionsTxt.linkTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.PrimaryColor.value]
        
        var haveAccSignInBtnTitle = HAVE_AN_ACCOUNT.localized()
        let singupNow = SIGNIN_NOW.localized()
        haveAccSignInBtnTitle.append(singupNow)
        haveAccSignInBtn.setTitle(haveAccSignInBtnTitle, for: .normal)
        
        placeHoldersAndBtns()
        
        passwordTxt.rx
            .controlEvent(.editingDidBegin)
            .asObservable()
            .subscribe {[unowned self] (_) in
            self.avoidKeyboard()
        }.disposed(by: bag)
        bindValuesToViewModel()
        
        haveAccSignInBtn.rx
            .tap
            .subscribe {[unowned self] (_) in
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: bag)
    }
    
    func placeHoldersAndBtns(){
        emailTxt.placeholder = EMAIL.localized()
        passwordTxt.placeholder = PASSWORD.localized()
        mobileTxt.placeholder = MOBILE_NUMBER.localized()
        firstNameTxt.placeholder = FIRST_NAME.localized()
        familyNameTxt.placeholder = FAMILY_NAME.localized()
        confirmPasswordTxt.placeholder = CONFIRM_PASSWORD.localized()
        signUpBtn.setTitle(SIGN_UP.localized(), for: .normal)
    }
    
    func bindValuesToViewModel(){
        emailTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.input.email)
            .disposed(by: bag)
        mobileTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.input.mobile)
            .disposed(by: bag)
        firstNameTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.input.firstName)
            .disposed(by: bag)
        familyNameTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.input.familyName)
            .disposed(by: bag)
        passwordTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.input.password)
            .disposed(by: bag)
        confirmPasswordTxt.rx
            .text
            .orEmpty
            .bind(to: viewModel.input.confirmPassword)
            .disposed(by: bag)
        viewModel.output
            .passwordValidate
            .subscribe { (event) in
                guard let isValidPassword = event.element else { return }
                
            }.disposed(by: bag)
        
    }
    
    func addLinkToText() -> NSMutableAttributedString{
        let string = PRIVACY_TEXT.localized().attributedString(fontSize: 17, color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
        let firstLink = T_C.localized().clickableString(gotolink: "https://etajer.maxsys.sa/")
        let and = AND.localized().attributedString()
        let secondLink = PRIVACY_POLICY.localized().clickableString(gotolink: "https://etajer.maxsys.sa/")
        
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
