//
//  AddressCell.swift
//  etajerIOS
//
//  Created by mohamed on 7/22/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxSwift

class AddressCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var bag = DisposeBag()
    var deleteAction: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        bag = DisposeBag()
    }
    
    func bindOnData(_ data: [String: Any]){
        nameLbl.text = "المصنع"
        addressLbl.text = "المملكة الهربية السعودية -2- الحمراء"
        mobileNumberLbl.text = "+966555555555"
        
        editBtn.rx
            .tap
            .bind { (_) in
                
        }.disposed(by: bag)
        
        deleteBtn.rx
            .tap
            .bind {[unowned self] (_) in
                self.deleteAction?()
        }.disposed(by: bag)
    }
        
}
