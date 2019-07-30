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
        let successMsg: Observable<String>
        let failer: Observable<[ErrorModel]>
        let passwordValidate: Observable<Bool>
        
    }
    
    private let email = PublishSubject<String>()
    private let mobile = PublishSubject<String>()
    private let firstName = PublishSubject<String>()
    private let familyName = PublishSubject<String>()
    private let password = PublishSubject<String>()
    private let confirmPassword = PublishSubject<String>()
    private let passwordValidate = PublishSubject<Bool>()
    private let success = PublishSubject<String>()
    private let failer = PublishSubject<[ErrorModel]>()
    
    override init() {
        self.input = Input(email: email.asObserver(),
                           mobile: mobile.asObserver(),
                           firstName: firstName.asObserver(),
                           familyName: familyName.asObserver(),
                           password: password.asObserver(),
                           confirmPassword: confirmPassword.asObserver())
        
        
        self.output = Output(successMsg: success.asObservable(),
                             failer: failer.asObservable(),
                             passwordValidate: passwordValidate.asObservable())
        
        super.init()
    }
    
    
    func signup(email: String, password: String, firstName: String, lastName: String, mobile: String){
        
        DataManager.shared.signup(email: email, password: password, firstName: firstName, lastName: lastName, mobile: mobile) { (response) in
            switch response {
            case .success(let value):
                guard let response = value as? SignInUpResponse else { return }
                guard let token = response.accessToken else { return }
                AppUtility.shared.saveToken(token)
                guard let user = response.identity else { return }
                AppUtility.shared.saveCurrentUser(user)
                guard let msg = response.message else { return }
                self.success.onNext(msg)
            case .failure( _, let data):
                self.handelApiError(data: data, failer: self.failer)
            }
        }
    }
    
    
}
