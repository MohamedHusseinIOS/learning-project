//
//  MyInfoViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 8/27/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class MyInfoViewModel: BaseViewModel, ViewModelType  {
    
    let output: Output
    let input: Input
    
    struct Input {}
    
    struct Output {
        let failure: Observable<[ErrorModel]>
        let user: Observable<User>
        let successMsg: Observable<String>
    }
    
    private let failure = PublishSubject<[ErrorModel]>()
    private let user = PublishSubject<User>()
    private let successMsg = PublishSubject<String>()
    
    override init() {
        self.input = Input()
        self.output = Output(failure: failure.asObservable(),
                             user: user.asObservable(),
                             successMsg: successMsg.asObservable())
    }
    
    func chnageUserData(firstName: String, lastName: String, email: String, mobile: String){
        DataManager.shared.changeUserData(firstName: firstName, lastName: lastName, email: email, mobile: mobile) { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let value):
                guard let res = value as? SignInUpResponse, let user = res.identity else { return }
                AppUtility.shared.saveCurrentUser(user)
                self.user.onNext(user)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.failure)
            }
        }
    }
    
    func changePassword(newPassword: String, confirmPassword: String) {
        DataManager.shared.changePassword(newPassword: newPassword, confirmPassword: confirmPassword) { (response) in
            switch response {
            case .success(let value):
                guard let res = value as? SignInUpResponse, let user = res.identity, let accessToken = res.accessToken else { return }
                AppUtility.shared.saveCurrentUser(user)
                AppUtility.shared.saveToken(accessToken)
                self.successMsg.onNext(PASSWORD_CHANED.localized())
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.failure)
            }

        }
    }
}
