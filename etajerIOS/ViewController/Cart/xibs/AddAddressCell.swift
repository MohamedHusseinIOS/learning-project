//
//  AddAddressCell.swift
//  etajerIOS
//
//  Created by mohamed on 7/24/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxSwift

class AddAddressCell: UITableViewCell {

    @IBOutlet weak var addAdressBtn: UIButton!
    
    var bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setup(){
        addAdressBtn.rx
            .tap
            .bind { (_) in
                NavigationCoordinator.shared.mainNavigator.present(.selectAddressViewController(nil), completion: nil)
        }.disposed(by: bag)
    }

    override func prepareForReuse() {
        bag = DisposeBag()
    }

}
