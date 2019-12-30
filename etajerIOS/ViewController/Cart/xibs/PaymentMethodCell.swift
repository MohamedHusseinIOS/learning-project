//
//  PaymentMethodCell.swift
//  etajerIOS
//
//  Created by mohamed on 7/25/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxSwift


enum PaymentMethod{
    case creditCard
    case cash
}

class PaymentMethodCell: UITableViewCell {

    @IBOutlet weak var creditCardSelectionImg: UIImageView!
    @IBOutlet weak var creditCardSelectionBtn: UIButton!
    @IBOutlet weak var cashSelectionImg: UIImageView!
    @IBOutlet weak var cashSelectionBtn: UIButton!
  
    var bag = DisposeBag()
    var selection: ((PaymentMethod)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cashSelectionImg.backgroundColor = #colorLiteral(red: 0.9391385317, green: 0.303278625, blue: 0.3176416159, alpha: 1)
    }
    
    func bindOnData() {
        
        creditCardSelectionBtn.rx
            .tap
            .bind {[unowned self] (_) in
                self.selection?(.creditCard)
                self.paymentMethodSelectionUI(.creditCard)
            }.disposed(by: bag)
        
        cashSelectionBtn.rx
            .tap
            .bind {[unowned self] (_) in
                self.selection?(.cash)
                self.paymentMethodSelectionUI(.cash)
            }.disposed(by: bag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    func paymentMethodSelectionUI(_ selection: PaymentMethod){
        switch selection {
        case .creditCard:
            creditCardSelectionImg.backgroundColor = #colorLiteral(red: 0.9391385317, green: 0.303278625, blue: 0.3176416159, alpha: 1)
            cashSelectionImg.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case .cash:
            creditCardSelectionImg.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cashSelectionImg.backgroundColor = #colorLiteral(red: 0.9391385317, green: 0.303278625, blue: 0.3176416159, alpha: 1)
        }
    }
    

}
