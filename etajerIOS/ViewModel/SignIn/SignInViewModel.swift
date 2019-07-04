//
//  SignInViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/4/19.
//  Copyright © 2019 mohamed ismail. All rights reserved.
//

import Foundation
import RxSwift

class SignInViewModel: BaseViewModel {
    
    var email = PublishSubject<String>()
    var password = PublishSubject<String>()
    var dispose = DisposeBag()
    
    override init() {
        email.subscribe { (event) in
            print(event.element)
        }.disposed(by: dispose)
        
        password.subscribe { (event) in
            print(event.element)
        }.disposed(by: dispose)
    }
}
