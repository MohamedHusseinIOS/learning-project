//
//  HomeViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/9/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel: BaseViewModel {
    
    var catrgories = PublishSubject<[Category]>()
    
    override init() {
        
    }
    
    
}
