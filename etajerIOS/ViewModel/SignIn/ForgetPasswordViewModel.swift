//
//  ForgetPasswordViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/7/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class ForgetPasswordViewModel: BaseViewModel{
    
    let email = PublishSubject<String>()
    let failer = PublishSubject<[ErrorModel]>()
    let successMsg = PublishSubject<String>()
    
    override init() {
        super.init()
    }
    
    func requestResetPassword(email: String){
        DataManager.shared.requestResetPassword(email: email) { (response) in
            switch response {
            case .success(let value):
                guard let response = value as? SignInUpResponse else { return }
                guard let msg = response.message else { return }
                self.successMsg.onNext(msg)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.failer)
            }
        }
    }
}
