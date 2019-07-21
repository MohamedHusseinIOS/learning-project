//
//  NotificationCell.swift
//  etajerIOS
//
//  Created by mohamed on 7/21/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class NotificationCell: UITableViewCell {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var notificationBodyLbl: UILabel!
    @IBOutlet weak var buyOfferBtnsStackView: UIStackView!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var hagglingBtn: UIButton!
    @IBOutlet weak var ignoreBtn: UIButton!
    @IBOutlet weak var detailsBtn: UIButton!
    
    var bag = DisposeBag()
    var closeAction: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        bag = DisposeBag()
    }
    
    func configureUI(buyOffer: Bool, notificationData: [String: Any]){
        
        if buyOffer {
            detailsBtn.isHidden = true
            buyOfferBtnsStackView.isHidden = false
        } else {
            detailsBtn.isHidden = false
            buyOfferBtnsStackView.isHidden = true
        }
        
        closeBtn.rx
            .tap
            .asDriver()
            .throttle(1)
            .drive(onNext: { [unowned self] (_) in
                self.closeAction?()
        }).disposed(by: bag)
        
        acceptBtn.rx
            .tap
            .subscribe { (_) in
                
        }.disposed(by: bag)
        
        hagglingBtn.rx
            .tap
            .subscribe { (_) in
                
        }.disposed(by: bag)
        
        ignoreBtn.rx
            .tap
            .subscribe { (_) in
                
        }.disposed(by: bag)
        
        detailsBtn.rx
            .tap
            .subscribe { (_) in
                NavigationCoordinator.shared.mainNavigator.navigate(To: .itemDetailsViewController)
        }.disposed(by: bag)
    }

}
