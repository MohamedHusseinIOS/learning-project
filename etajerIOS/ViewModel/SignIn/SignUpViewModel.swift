//
//  SignUpViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/4/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class SignUpViewModel: BaseViewModel, ViewModelType {
    
    var input: Input
    var output: Output
    
    struct Input {
        let email: AnyObserver<String>
        let mobile: AnyObserver<String>
        let firstName: AnyObserver<String>
        let familyName: AnyObserver<String>
        let password: AnyObserver<String>
        let confirmPassword: AnyObserver<String>
    }
    
    struct Output {
        let success: Observable<Bool>
        let passwordValidate: Observable<Bool>
    }
    
    private let email = PublishSubject<String>()
    private let mobile = PublishSubject<String>()
    private let firstName = PublishSubject<String>()
    private let familyName = PublishSubject<String>()
    private let password = PublishSubject<String>()
    private let confirmPassword = PublishSubject<String>()
    private let passwordValidate = PublishSubject<Bool>()
    private let success = PublishSubject<Bool>()
    
    override init() {
        self.input = Input(email: email.asObserver(),
                           mobile: mobile.asObserver(),
                           firstName: firstName.asObserver(),
                           familyName: familyName.asObserver(),
                           password: password.asObserver(),
                           confirmPassword: confirmPassword.asObserver())
        
        
        self.output = Output(success: success.asObservable(),
                             passwordValidate: passwordValidate.asObservable())
        
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
        var passwordTxt = ""
        password.asObserver().subscribe { (event) in
            guard let value = event.element else{return}
            passwordTxt = value
        }.disposed(by: bag)
        confirmPassword.asObserver().subscribe {[unowned self] (event) in
            guard let value = event.element else{return}
            self.passwordValidate.onNext(value == passwordTxt)
        }.disposed(by: bag)
        
    }
    
}
