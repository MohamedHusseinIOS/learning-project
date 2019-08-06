//
//  filterCell.swift
//  etajerIOS
//
//  Created by mohamed on 8/6/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxSwift

class FilterCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var categorySwitch: UISwitch!
    
    static let reuseIdentifire = "FilterCell"
    var bag = DisposeBag()
    var switchChanged: ((Bool, String)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        categorySwitch.rx
            .controlEvent(.valueChanged)
            .bind {[unowned self] (_) in
                guard let title = self.titleLbl.text else { return }
                self.switchChanged?(self.categorySwitch.isOn, title)
        }.disposed(by: bag)
    }
    
    func bindOn(name: String?, switchCallBack: ((Bool, String)->Void)?){
        titleLbl.text = name
        switchChanged = switchCallBack
    }
    
    override func prepareForReuse() {
        bag = DisposeBag()
    }

    
}
