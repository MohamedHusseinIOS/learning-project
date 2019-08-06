//
//  FilterSectionHeaderCell.swift
//  etajerIOS
//
//  Created by mohamed on 8/6/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit

class FilterSectionHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var sectionTitleLbl: UILabel!
    @IBOutlet weak var dropDownArrowImg: UIImageView!
    
    static let reuseIdentifire = "FilterSectionHeader"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
