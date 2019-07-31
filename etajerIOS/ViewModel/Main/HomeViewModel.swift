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
    
    struct HomeData {
        var title: Title?
        var data: Any?
        
        enum Title: String {
            case latestProduct
            case latestAuction
            case adsUnderAuction
            case bottomCategories
        }
    }
    
    struct Input {}
    
    struct Output {
        let homeData: Observable<[HomeViewModel.HomeData]>
        let scrollEmemnets: Observable<[Ads]>
        let failer: Observable<[ErrorModel]>
    }
    
    
    
    private let homeData = PublishSubject<[HomeViewModel.HomeData]>()
    private let scrollEmemnets = PublishSubject<[Ads]>()
    private let failer = PublishSubject<[ErrorModel]>()
    
    override init() {
        self.output = Output(homeData: homeData.asObservable(),
                             scrollEmemnets: scrollEmemnets.asObservable(),
                             failer: failer.asObservable())
        self.input = Input()
    }
    
    func getHome(){
        DataManager.shared.gethomePage {[unowned self] (response) in
            switch response {
            case .success(let value):
                
                guard let homeRes = value as? HomeResponse,
                      let ads = homeRes.ads1,
                      let lastProducts = homeRes.latestProducts,
                      let lastAuction = homeRes.latestAuctions,
                      let adsUnderAuction = homeRes.adsUnderAuctions,
                      let bottomCatrgories = homeRes.bottomCategories else {return}
                
                let dataArr = [HomeData(title: .latestProduct, data: lastProducts),
                               HomeData(title: .latestAuction, data: lastAuction),
                               HomeData(title: .adsUnderAuction, data: adsUnderAuction),
                               HomeData(title: .bottomCategories, data: bottomCatrgories)]
                
                self.homeData.onNext(dataArr)
                self.scrollEmemnets.onNext(ads)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.failer)
            }
        }
    }
}
