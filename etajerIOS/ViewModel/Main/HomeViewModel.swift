//
//  HomeViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/9/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel: BaseViewModel, ViewModelType {
    
    var input: Input
    var output: Output
    
    struct Input {
        let categories: AnyObserver<[Category]>
    }
    
    struct Output {
        let categories: Observable<[Category]>
    }
    
    private let categories = PublishSubject<[Category]>()
    
    override init() {
        self.output = Output(categories: categories.asObservable())
        self.input = Input(categories: categories.asObserver())
    }
    
}
