//
//  MyAccountCell.swift
//  etajerIOS
//
//  Created by mohamed on 7/17/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import UIKit

class MyAccountCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func bindOn(_ myAccountElemnt: MyAccountElements){
        titleLbl.text = myAccountElemnt.title
        iconImg.image = myAccountElemnt.icon
    }
}
