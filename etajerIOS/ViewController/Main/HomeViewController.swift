//
//  HomeViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/8/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: BaseViewController {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var changeLang: UIButton!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var sliderScrollView: UIScrollView!
    @IBOutlet weak var sliderPageControl: UIPageControl!
    
    
    let viewModel = HomeViewModel()
    var banners = [#imageLiteral(resourceName: "baner1"),#imageLiteral(resourceName: "baner2"),#imageLiteral(resourceName: "baner3")]
    
    let categories: [Category] = [Category(title: CATEGORY_TITLE_1.localized(),
                                           items: [Item(name: "شاشة سامسونج",
                                                        price: "3000 س.ر",
                                                        image: #imageLiteral(resourceName: "screen"),
                                                        rating: 3,
                                                        overbid: ""),
                                                   Item(name: "لكرس إى اس 350",
                                                        price: "45000 س.ر",
                                                        image: #imageLiteral(resourceName: "lexus"),
                                                        rating: 5,
                                                        overbid: "")]),
                                  Category(title: CATEGORY_TITLE_2.localized(),
                                           items:[Item(name: "سجادة سرات",
                                                       price: "108888 س.ر",
                                                       image: #imageLiteral(resourceName: "carpet"),
                                                       rating: 4,
                                                       overbid: "اخر مزايدة"),
                                                  Item(name: "شاشة ال جي",
                                                       price: "2000 س.ر",
                                                       image: #imageLiteral(resourceName: "lgScreen"),
                                                       rating: 4,
                                                       overbid: "اخر مزايدة")]),
                                  Category(title: "بانر", items: []),
                                  Category(title: "HELTH_AND_SELF_CARE".localized(),
                                           items: [Item(name: "شاشة سامسونج",
                                                        price: "3000 س.ر",
                                                        image: #imageLiteral(resourceName: "screen"),
                                                        rating: 3,
                                                        overbid: ""),
                                                   Item(name: "لكرس إى اس 350",
                                                        price: "45000 س.ر",
                                                        image: #imageLiteral(resourceName: "lexus"),
                                                        rating: 5,
                                                        overbid: "")]),
                                  Category(title: "MOBILES_AND_TAPLETS".localized(),
                                           items: [Item(name: "شاشة سامسونج",
                                                        price: "3000 س.ر",
                                                        image: #imageLiteral(resourceName: "screen"),
                                                        rating: 3,
                                                        overbid: ""),
                                                   Item(name: "لكرس إى اس 350",
                                                        price: "45000 س.ر",
                                                        image: #imageLiteral(resourceName: "lexus"),
                                                        rating: 5,
                                                        overbid: "")])]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.catrgories.onNext(categories)
        registerCell()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //setupScrollView()
    }
    
    func registerCell(){
        let nib = UINib(nibName: "CategoryCell", bundle: .main)
        homeTableView.register(nib, forCellReuseIdentifier: "CategoryCell")
        let bannerCellNib = UINib(nibName: "BannerCell", bundle: .main)
        homeTableView.register(bannerCellNib, forCellReuseIdentifier: "BannerCell")
    }
    
    override func configureUI() {
        super.configureUI()
        
        changeLang.setTitle(CHANGE_LANG.localized(), for: .normal)
        
        menuBtn.rx
            .tap
            .subscribe {[unowned self] (_) in
                self.openMenu()
            }.disposed(by: bag)
        
        changeLang.rx
            .tap
            .subscribe { (_) in
                AppUtility.shared.changeLanguage()
        }.disposed(by: bag)
        
        configureTableView()
        didSelectRow()
        sliderScrollView.rx
            .didEndDecelerating
            .subscribe {[unowned self] (_) in
                if AppUtility.shared.currentLang == .ar {
                    let pageNumber = round(self.sliderScrollView.contentOffset.x / self.sliderScrollView.frame.width)
                    //let isLastPage = (Int(pageNumber) == self.banners.count - 1)
                    self.sliderPageControl.currentPage = Int(pageNumber)
                } else {
                    let pageNumber = round(self.sliderScrollView.contentOffset.x / self.sliderScrollView.frame.width)
                    self.sliderPageControl.currentPage = Int(pageNumber)
                }
        }.disposed(by: bag)
        
        sliderPageControl.rx
            .controlEvent(.valueChanged)
            .subscribe {[unowned self] (_) in
                if AppUtility.shared.currentLang == .ar{
                    
                }
                let x = CGFloat(self.sliderPageControl.currentPage) * self.sliderScrollView.frame.size.width
                self.sliderScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
        }.disposed(by: bag)
        
        configureTableView()
        didSelectRow()
    }
    
    func configureTableView(){
        homeTableView.delegate = nil
        homeTableView.dataSource = nil
        homeTableView.separatorStyle = .none
        viewModel.catrgories
            .bind(to: homeTableView.rx.items){ tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                guard row != 2 else{
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath) as? BannerCell else {return BannerCell()}
                    cell.imageView?.contentMode = .scaleAspectFill
                    cell.bannerImg.image = #imageLiteral(resourceName: "baner4")
                    return cell
                }
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {return CategoryCell()}
                guard let items = element.items else {return cell}
                cell.categoryNameLbl.text = element.title
                cell.moreItemsLbl.text = MORE_ITEMS.localized()
                cell.categoryItems.onNext(items)
                return cell
        }.disposed(by: bag)
    }
    
    func didSelectRow(){
        homeTableView.rx.itemSelected.bind { (indexPath) in
            //code
        }.disposed(by: bag)
    }
    
    func setupScrollView(){
        
        sliderScrollView.subviews.forEach({ $0.removeFromSuperview() })
        sliderPageControl.numberOfPages = banners.count
        sliderScrollView.contentSize.width = (view.bounds.width) * CGFloat(banners.count)
        sliderScrollView.contentSize.height = headerView.bounds.height
        let childOfScrollView = UIView()
        sliderScrollView.addSubview(childOfScrollView)
        sliderScrollView.isPagingEnabled = true
        sliderScrollView.bounces = false
        var viewsArray = [UIView]()
        for item in banners.enumerated() {
            let containerView = UIView()
            let scrollWidth = view.bounds.width
            let scrollSize = sliderScrollView.bounds.size
            let containerPoint = CGPoint(x: scrollWidth * CGFloat(item.offset),
                                         y: 0)
            containerView.backgroundColor = UIColor.clear
            containerView.frame.origin = containerPoint
            containerView.frame.size.width = view.bounds.width
            containerView.frame.size.height = scrollSize.height
            containerView.tag = item.offset
            
            let viewOrigin = CGPoint(x: 0 , y: 0)
            let viewSize = containerView.bounds.size//CGSize(width: AppUtility.shared.screenWidth, height: sliderScrollView.frame.height)
            let imageView = UIImageView()
            
            imageView.contentMode = .scaleAspectFill
            imageView.frame = CGRect(origin: viewOrigin, size: viewSize)
            imageView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            // newsView.newsImg.image = #imageLiteral(resourceName: "contact_unactive")
            imageView.image = item.element
            
            containerView.addSubview(imageView)
            viewsArray.append(containerView)
            childOfScrollView.addSubview(containerView)
        }
        
        addConstrainsOf(containers: viewsArray, to: childOfScrollView)
        addConstraintsTo(scrollView: sliderScrollView, and: childOfScrollView)

        sliderScrollView.bringSubviewToFront(sliderPageControl)
        if AppUtility.shared.currentLang == .ar{
    
        }
    }
    
    func addConstraintsTo(scrollView: UIScrollView, and parentOfContainers: UIView){
        let leftConst = NSLayoutConstraint(item: parentOfContainers,
                                           attribute: .left,
                                           relatedBy: .equal,
                                           toItem: scrollView,
                                           attribute: .left,
                                           multiplier: 1,
                                           constant: 0)
        let topConst = NSLayoutConstraint(item: parentOfContainers,
                                          attribute: .top,
                                          relatedBy: .equal,
                                          toItem: scrollView,
                                          attribute: .top,
                                          multiplier: 1,
                                          constant: 0)
        let bottomConst = NSLayoutConstraint(item: parentOfContainers,
                                             attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: scrollView,
                                             attribute: .bottom,
                                             multiplier: 1,
                                             constant: 0)
        let rightConst = NSLayoutConstraint(item: parentOfContainers,
                                            attribute: .right,
                                            relatedBy: .equal,
                                            toItem: scrollView,
                                            attribute: .right,
                                            multiplier: 1,
                                            constant: 0)
        
        scrollView.addConstraints([leftConst, topConst, bottomConst, rightConst])
        scrollView.updateConstraints()
        
    }
    
    func addConstrainsOf(containers: [UIView], to parentView: UIView){
        parentView.translatesAutoresizingMaskIntoConstraints = false
        guard let firstView = containers.filter({$0.tag == 0}).first else { return }
        let firstWidthConst = NSLayoutConstraint(item: firstView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: AppUtility.shared.screenWidth)
        guard let secondView = containers.filter({$0.tag == 1}).first else { return }
        let secondWidthConst = NSLayoutConstraint(item: secondView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: AppUtility.shared.screenWidth)
        guard let theardView = containers.filter({$0.tag == 2}).first else { return }
        let theardWidthConst = NSLayoutConstraint(item: theardView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: AppUtility.shared.screenWidth)
        
        let leftConstraintOfFirst = firstView.leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: 0)
        let rightConstraintOfFirst = firstView.rightAnchor.constraint(equalTo: secondView.leftAnchor, constant: 0)
        let leftConstraintOfTheard = theardView.leftAnchor.constraint(equalTo: secondView.rightAnchor, constant: 0)
        let rightconstraintOfTheard = theardView.rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: 0)
        parentView.addConstraints([firstWidthConst,
                                   secondWidthConst,
                                   theardWidthConst,
                                   leftConstraintOfFirst,
                                   rightConstraintOfFirst,
                                   leftConstraintOfTheard,
                                   rightconstraintOfTheard])
        parentView.updateConstraints()
    }
    
}
