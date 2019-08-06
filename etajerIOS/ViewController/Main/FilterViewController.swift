//
//  FilterViewController.swift
//  etajerIOS
//
//  Created by mohamed on 8/6/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxDataSources
import RxCocoa

class FilterViewController: BaseViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var filterTableView: UITableView!
    
    var category: Category?
    let viewModel = FilterViewModel()
    var filterCallback: (([String: Bool])->Void)?
    var filterDict = [String: Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getSubCategoryForm(category: category)
    }

    override func configureUI() {
        super.configureUI()
        
        doneBtn.rx.tap.bind {[unowned self] (_) in
            self.filterCallback?(self.filterDict)
        }.disposed(by: bag)
        
        resetBtn.rx.tap.bind { (_) in
            self.filterDict.removeAll()
            self.filterDict.updateValue(true, forKey: PRODUCTS.localized())
            // CATEGORY_TITLE_2 >>> its for Auction
            self.filterDict.updateValue(true, forKey: CATEGORY_TITLE_2.localized())
            self.filterTableView.reloadData()
        }.disposed(by: bag)
    }
    
    override func configureData() {
        super.configureData()
    }

    func configureTableView(){
        filterTableView.rx.setDelegate(self).disposed(by: bag)
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,Category>>(configureCell: {[unowned self] (datasoucre, tableView, indexPath, item) -> UITableViewCell in
            return self.makeCellAt(indexPath: indexPath, data: item, for: tableView)
        })
        viewModel.output.data.bind(to: filterTableView.rx.items(dataSource: dataSource)).disposed(by: bag)
    }
    
    func makeCellAt(indexPath: IndexPath, data: Category, for tableView: UITableView) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.reuseIdentifire, for: indexPath) as? FilterCell else { return FilterCell() }
        guard let name = data.name else {return cell}
        cell.categorySwitch.isOn = filterDict[name] ?? false
        cell.bindOn(name: name) {[unowned self] isOn, name in
            self.filterDict.updateValue(isOn, forKey: name)
        }
        return cell
    }
    
    func makeHeaderForSection(_ section: Int, in tableView: UITableView) -> UIView {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FilterSectionHaeder") else { return UIView() }
        return header
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return makeHeaderForSection(section, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
