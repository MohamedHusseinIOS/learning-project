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
            case bottomCategories = "categories"
        }
    }
    
    struct Input {}
    
    struct Output {
        let homeData: Observable<[HomeViewModel.HomeData]>
        let scrollElemnets: Observable<[Ads]>
        let failer: Observable<[ErrorModel]>
    }
    
    private let homeData = PublishSubject<[HomeViewModel.HomeData]>()
    private let scrollElemnets = PublishSubject<[Ads]>()
    private let failer = PublishSubject<[ErrorModel]>()
    
    override init() {
        self.output = Output(homeData: homeData.asObservable(),
                             scrollElemnets: scrollElemnets.asObservable(),
                             failer: failer.asObservable())
        self.input = Input()
    }
    
    func getHome(parent: HomeViewController){
        
        DataManager.shared.gethomePage {[unowned self] (response) in
            switch response {
            case .success(let value):
                parent.homeTableView.delegate = nil
                parent.homeTableView.dataSource = nil
                guard let homeRes = value as? HomeResponse,
                      var ads = homeRes.ads1,
                      let lastProducts = homeRes.latestProducts,
                      let lastAuction = homeRes.latestAuctions,
                      let adsUnderAuction = homeRes.adsUnderAuctions,
                      let bottomCatrgories = homeRes.bottomCategories else {return}
                
                let dataArr = [HomeData(title: .latestProduct, data: lastProducts),
                               HomeData(title: .latestAuction, data: lastAuction),
                               HomeData(title: .adsUnderAuction, data: adsUnderAuction),
                               HomeData(title: .bottomCategories, data: bottomCatrgories)]
                parent.configureTableView()
                self.homeData.onNext(dataArr)
                ads.reverse()
                self.scrollElemnets.onNext(ads)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.failer)
            }
        }
    }
}
