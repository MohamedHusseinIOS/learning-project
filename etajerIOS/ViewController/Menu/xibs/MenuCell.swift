//
//  MenuCell.swift
//  etajerIOS
//
//  Created by mohamed on 7/7/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var elementLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if AppUtility.shared.currentLang == .ar{
            elementLbl.textAlignment = .right
        }else{
            elementLbl.textAlignment = .left
        }
    }

    func bindOn(_ data: MenuElements){
        elementLbl.text = data.title
    }
}
