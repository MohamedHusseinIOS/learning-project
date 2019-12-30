//
//  YourOrderItemsCell.swift
//  etajerIOS
//
//  Created by mohamed on 7/25/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class YourOrderItemsCell: UITableViewCell {

    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var TVHeightConstraint: NSLayoutConstraint!
    
    var items = PublishSubject<[CartProduct]>()
    var bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        bag = DisposeBag()
    }

    func bindOnData(items: [CartProduct]) {
        registerCell()
        configureTableView()
        self.items.onNext(items)
    }
    
    func registerCell(){
        let nib = UINib(nibName: "CartCell", bundle: .main)
        itemsTableView.register(nib, forCellReuseIdentifier: "CartCell")
    }
    
    func configureTableView(){
        items.bind {[unowned self] (items) in
            self.TVHeightConstraint.constant = 108 * CGFloat(items.count)
        }.disposed(by: bag)
        
        items.bind(to: itemsTableView.rx.items){[unowned self] tableView, row, element in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = self.dequeueCartCell(tableView: tableView, indexPath: indexPath, data: element)
            return cell
        }.disposed(by: bag)
    }
    
    func dequeueCartCell(tableView: UITableView, indexPath: IndexPath, data: CartProduct) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell else { return CartCell() }
        cell.bindOnData(data)
        cell.numberOfItemsContainer.isHidden = true
        cell.deleteBtn.isHidden = true
        return cell
    }
}
