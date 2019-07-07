//
//  SignUpViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/4/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class SignUpViewModel: BaseViewModel {
    
    var email = PublishSubject<String>()
    var mobile = PublishSubject<String>()
    var firstName = PublishSubject<String>()
    var familyName = PublishSubject<String>()
    var password = PublishSubject<String>()
    var confirmPassword = PublishSubject<String>()
    
    override init() {
        super.init()
        
        email.asObserver().subscribe { (event) in
            guard let value = event.element else{return}
        }.disposed(by: bag)
        mobile.asObserver().subscribe { (event) in
            guard let value = event.element else{return}
        }.disposed(by: bag)
        firstName.asObserver().subscribe { (event) in
            guard let value = event.element else{return}
        }.disposed(by: bag)
        familyName.asObserver().subscribe { (event) in
            guard let value = event.element else{return}
        }.disposed(by: bag)
        password.asObserver().subscribe { (event) in
            guard let value = event.element else{return}
        }.disposed(by: bag)
        confirmPassword.asObserver().subscribe { (event) in
            guard let value = event.element else{return}
        }.disposed(by: bag)
    }
    
}
