//
//  SignUpViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/4/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxCocoa

class SignUpViewController: BaseViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var mobileTxt: UITextField!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var familyNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var termsAndConditionsLbl: UILabel!
    @IBOutlet weak var haveAccSignInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureUI() {
        super.configureUI()
        termsAndConditionsLbl.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(termsAndCondetionsTapped(_:)))
        termsAndConditionsLbl.addGestureRecognizer(tap)
        
        
        
    }
    
    func addLinkToText() -> (NSMutableAttributedString, NSRange, NSRange){
        let string = NSMutableAttributedString(string: "بالضغط على زر تسجيل حساب جديد، فإنك توافق علي")
        let startRangeOfFirstLink = string.string.count - 1
        let firstLink = " الشروط والاحكام ".clickableString(gotolink: "www.google.com")
        let lenghtFirstLink = firstLink.string.count
        
        let and = NSMutableAttributedString(string: "و")
        
        let startRangeOfSecondLink = startRangeOfFirstLink + (lenghtFirstLink - 1) + 1
        let secondLink = " سياسةالخصوصية ".clickableString(gotolink: "")
        let lengthSecondLink = secondLink.string.count
        
        string.append(firstLink)
        string.append(and)
        string.append(secondLink)
        
        let firstLinkRange = NSRange(location: startRangeOfFirstLink, length: lenghtFirstLink)
        let secondLinkRange = NSRange(location: startRangeOfSecondLink, length: lengthSecondLink)
        
        return (string, firstLinkRange, secondLinkRange)
    }
    
    
    @objc func termsAndCondetionsTapped(_ sender: UITapGestureRecognizer){
        
    }
}
