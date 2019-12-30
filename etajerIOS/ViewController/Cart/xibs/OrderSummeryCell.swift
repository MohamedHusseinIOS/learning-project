//
//  OrderSummeryCell.swift
//  etajerIOS
//
//  Created by mohamed on 7/25/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit

class OrderSummeryCell: UITableViewCell {
    
    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var delevaryFees: UILabel!
    @IBOutlet weak var cashOnDelevaryFees: UILabel!
    @IBOutlet weak var totalPlasVat: UILabel!
    @IBOutlet weak var vatValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        
    }
    
    func bindOnData(items:[CartProduct]?, paymentMethpd: PaymentMethod?){
        var totalPrice = 0
        items?.forEach({ totalPrice += (Int($0.price ?? "") ?? 0) })
        delevaryFees.text = "\(6)\(S_R.localized())"
        switch paymentMethpd {
        case .some(.cash):
            cashOnDelevaryFees.text = "\(17) \(S_R.localized())"
        case .some(.creditCard):
            cashOnDelevaryFees.text = "\(0) \(S_R.localized())"
        default:
            break
        }
    }

}
