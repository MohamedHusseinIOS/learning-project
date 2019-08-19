//
//  AddressCell.swift
//  etajerIOS
//
//  Created by mohamed on 7/22/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxSwift
import SkeletonView

class AddressCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var bag = DisposeBag()
    var deleteAction: (()->Void)?
    var editAddress: ((String?)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        bag = DisposeBag()
    }
    
    func bindOnData(_ data: Address){
        stopSkeleton()
        nameLbl.text = data.name
        addressLbl.text = "\(data.building ?? "") \(data.street ?? ""),\(data.desc ?? ""),\(data.area ?? ""),\(data.city ?? ""),\(data.country ?? "")"
        mobileNumberLbl.text = data.mobile
        
        editBtn.rx
            .tap
            .bind {[unowned self] (_) in
                self.editAddress?(self.addressLbl.text)
        }.disposed(by: bag)
        
        deleteBtn.rx
            .tap
            .bind {[unowned self] (_) in
                self.deleteAction?()
        }.disposed(by: bag)
        
    }
    
    func activeSkeleton(){
        
        nameLbl.showAnimatedGradientSkeleton()
        addressLbl.showAnimatedGradientSkeleton()
        mobileNumberLbl.showAnimatedGradientSkeleton()
        editBtn.showAnimatedGradientSkeleton()
        deleteBtn.showAnimatedGradientSkeleton()
    }

    func stopSkeleton(){
        containerView.hideSkeleton()
        nameLbl.hideSkeleton()
        addressLbl.hideSkeleton()
        mobileNumberLbl.hideSkeleton()
        editBtn.hideSkeleton()
        deleteBtn.hideSkeleton()
    }
}
