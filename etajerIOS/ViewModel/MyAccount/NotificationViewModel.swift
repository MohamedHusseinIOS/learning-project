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
    
    struct Input {}
    
    struct Output {
        var notifications: Observable<[Notification]>
        var faliure: Observable<[ErrorModel]>
    }
    
    private var faliure  = PublishSubject<[ErrorModel]>()
    private var notifications = PublishSubject<[Notification]>()
    
    var pageNum = 1
    var pastLastIndex = 0
    var notificationsArray = [Notification]()
    var newPageNotifications = [Notification]()
    
    override init() {
        input = Input()
        output = Output(notifications: notifications.asObservable(),
                        faliure: faliure.asObservable())
        super.init()
        notifications.bind {[unowned self] (notifications) in
            self.handleNewPage(notifications: notifications)
        }.disposed(by: bag)
    }
    
    func handleNewPage(notifications: [Notification]){
        self.newPageNotifications = notifications
        pastLastIndex = self.notificationsArray.count - 1
        self.notificationsArray.append(contentsOf: notifications)
        self.pageNum += 1
    }
    
    func getNotifications(){
        DataManager.shared.getNotification(page: pageNum) {[unowned self] (response) in
            switch response {
            case .success(let value):
                guard let notificationRes = value as? NotificationResponse, let notifications = notificationRes.notifications else { return }
                self.notifications.onNext(notifications)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.faliure)
            }
        }
    }
    
}
