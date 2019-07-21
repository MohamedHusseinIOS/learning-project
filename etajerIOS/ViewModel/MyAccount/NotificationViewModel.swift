//
//  NotificationViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/21/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class NotificationViewModel: BaseViewModel, ViewModelType {
    
    var input: NotificationViewModel.Input
    var output: NotificationViewModel.Output
    
    struct Input {
        var notifications: AnyObserver<[[String: Any]]>
    }
    
    struct Output {
        var notifications: Observable<[[String: Any]]>
    }
    
    private var notifications = PublishSubject<[[String: Any]]>()
    private var dataArray = [[String: Any]]()
    
    override init() {
        input = Input(notifications: notifications.asObserver())
        output = Output(notifications: notifications.asObservable())
        super.init()
        notifications.subscribe {[unowned self] (event) in
            guard let array = event.element else { return }
            self.dataArray = array
        }.disposed(by: bag)
    }
    
    func removeItem(at index: IndexPath) {
        dataArray.remove(at: index.row)
        notifications.onNext(dataArray)
    }
    
}
