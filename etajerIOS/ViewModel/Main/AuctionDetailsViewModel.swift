//
//  AuctionDetailsViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/16/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class AuctionDetailsViewModel: BaseViewModel, ViewModelType{
    
    var input: Input
    var output: Output
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    override init() {
        self.input = Input()
        self.output = Output()
        super.init()
    }
}
