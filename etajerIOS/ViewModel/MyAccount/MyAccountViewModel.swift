//
//  MyAccountViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/17/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class MyAccountViewModel: BaseViewModel, ViewModelType{
    
    var input: Input
    var output: Output
    
    struct Input {
        var myAccountElements: AnyObserver<[MyAccountElements]>
    }
    
    struct Output {
        var myAccountElements: Observable<[MyAccountElements]>
    }
    
    private let myAccountElements = PublishSubject<[MyAccountElements]>()
    
    override init() {
        self.input = Input(myAccountElements: myAccountElements.asObserver())
        self.output = Output(myAccountElements: myAccountElements.asObservable())
        super.init()
    }
    
    func sendElemnts(){
        var accountItems = [MyAccountElements]()
        for i in 0...5 {
            accountItems.append(MyAccountElements.element(row: i))
        }
        myAccountElements.onNext(accountItems)
    }
    
}
