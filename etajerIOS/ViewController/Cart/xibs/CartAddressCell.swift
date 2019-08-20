//
//  AddressCell.swift
//  etajerIOS
//
//  Created by mohamed on 7/24/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxSwift

class CartAddressCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var editLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    
    var deleteAction: (()->Void)?
    var bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        bag = DisposeBag()
    }
    
    func bindOnData(_ data: Address) {
        self.titleLbl.text = data.name
        self.usernameLbl.text = AppUtility.shared.getCurrentUser()?.name
        self.addressLbl.text = "\(data.building ?? "") \(data.street ?? ""),\(data.desc ?? ""),\(data.area ?? ""),\(data.city ?? ""),\(data.country ?? "")"
        self.mobileLbl.text = data.mobile
        
        deleteBtn.rx
            .tap
            .bind { [weak self] (_) in
                guard let self = self else { return }
                self.deleteAction?()
            }.disposed(by: bag)
    }
    
}
