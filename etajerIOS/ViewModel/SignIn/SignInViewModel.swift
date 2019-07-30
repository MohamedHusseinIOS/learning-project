//
//  SignInViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/4/19.
//  Copyright © 2019 mohamed ismail. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SignInViewModel: BaseViewModel, ViewModelType {
    
    var input: Input
    var output: Output
    
    private let email = PublishSubject<String>()
    private let password = PublishSubject<String>()
    private let success = PublishSubject<Bool>()
    private let failer = PublishSubject<[ErrorModel]>()
    
    struct Input {
        let email: AnyObserver<String>
        let password: AnyObserver<String>
    }
    
    struct Output {
        let success: Observable<Bool>
        let failer: Observable<[ErrorModel]>
    }
    
    override init() {
        self.input = Input(email: email.asObserver(),
                           password: password.asObserver())
        self.output = Output(success: success.asObservable(),
                             failer: failer.asObservable())
        super.init()
    }
    
    func signIn(email: String, password: String){
        DataManager.shared.login(email: email, password: password) { (response) in
            switch response {
            case .success(let value):
                guard let response = value as? SignInUpResponse else { return }
                guard let token = response.accessToken else { return }
                AppUtility.shared.saveToken(token)
                guard let user = response.identity else { return }
                AppUtility.shared.saveCurrentUser(user)
                self.success.onNext(true)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.failer)
            }
        }
    }
}
