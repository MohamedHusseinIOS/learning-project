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
    
    override init() {
        super.init()
        email.asObserver().subscribe { (event) in
            guard let value = event.element else{return}
        }.disposed(by: bag)
    }
}
