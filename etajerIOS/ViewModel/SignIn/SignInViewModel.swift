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
    
    struct Input {
        let email: AnyObserver<String>
        let password: AnyObserver<String>
        
    }
    
    struct Output {
        let success: Observable<Bool>
    }
    
    //Not using for now
    func transfrom(input: SignInViewModel.Input) -> SignInViewModel.Output {
        return Output(success: success.asObservable())
    }
    
    override init() {
        self.input = Input(email: email.asObserver(), password: password.asObserver())
        self.output = Output(success: success.asObservable())
        
        super.init()
        self.bindOn()
    }
    
    func bindOn(){
        email.asObserver().subscribe { (event) in
            guard let email = event.element else{return}
            print(email)
        }.disposed(by: bag)
        
        password.asObserver().subscribe { (event) in
            guard let password = event.element else{return}
            print(password)
        }.disposed(by: bag)
    }
}
