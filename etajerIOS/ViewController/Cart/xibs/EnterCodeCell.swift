//
//  EnterCodeCell.swift
//  etajerIOS
//
//  Created by mohamed on 7/24/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EnterCodeCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var enterCodeTxt: UITextField!
    @IBOutlet weak var submit: UIButton!
    
    var bag = DisposeBag()
    var code: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        submit.rx
            .tap
            .bind {[unowned self] (_) in
               self.code = self.enterCodeTxt.text
        }.disposed(by: bag)
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }

}
