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
    @IBOutlet weak var cartBtn: UIButton!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var sliderScrollView: UIScrollView!
    @IBOutlet weak var sliderPageControl: UIPageControl!
    
    
    let viewModel = HomeViewModel()
    var banners = [#imageLiteral(resourceName: "baner1"),#imageLiteral(resourceName: "baner2"),#imageLiteral(resourceName: "baner3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCell()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupScrollView()
    }
    
    func registerCell(){
        let nib = UINib(nibName: "CategoryCell", bundle: .main)
        homeTableView.register(nib, forCellReuseIdentifier: "CategoryCell")
        let bannerCellNib = UINib(nibName: "BannerCell", bundle: .main)
        homeTableView.register(bannerCellNib, forCellReuseIdentifier: "BannerCell")
    }
    
    override func configureUI() {
        super.configureUI()
        
        menuBtn.rx
            .tap
            .subscribe {[unowned self] (_) in
                self.openMenu()
        }.disposed(by: bag)
        
        cartBtn.rx
            .tap
            .subscribe { (_) in
                NavigationCoordinator.shared.mainNavigator.navigate(To: .cartViewController)
        }.disposed(by: bag)
        
        configureTableView()
        didSelectRow()
        sliderScrollView.rx
            .didEndDecelerating
            .subscribe {[unowned self] (_) in
                let pageNumber = round(self.sliderScrollView.contentOffset.x / self.sliderScrollView.frame.width)
                self.sliderPageControl.currentPage = Int(pageNumber)
        }.disposed(by: bag)
        
        sliderPageControl.rx
            .controlEvent(.valueChanged)
            .subscribe {[unowned self] (_) in
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
        viewModel.output
            .homeData
            .bind(to: homeTableView.rx.items){ tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = self.makeCellin(indexPath: indexPath, byTableView: tableView, element: element)
                return cell
        }.disposed(by: bag)
    }
    
    func makeCellin(indexPath: IndexPath, byTableView tableView: UITableView, element: HomeViewModel.HomeData) -> UITableViewCell {
        
        guard indexPath.row != 2 else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath) as? BannerCell else {return BannerCell()}
            cell.imageView?.contentMode = .scaleAspectFill
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {return CategoryCell()}
        guard let items = element.data as? [Product]  else { return cell }
        cell.parent = self
        cell.categoryNameLbl.text = element.title?.rawValue
        cell.moreItemsLbl.text = MORE_ITEMS.localized()
        cell.categoryItems.onNext(items)
        return cell
    }
    
    func didSelectRow(){
        homeTableView.rx
            .itemSelected
            .bind { (indexPath) in
            //code
        }.disposed(by: bag)
    }
    
    func setupScrollView(){
        sliderScrollView.subviews.forEach({ $0.removeFromSuperview() })
        sliderPageControl.numberOfPages = banners.count
        sliderScrollView.contentSize.width = (view.bounds.width) * CGFloat(banners.count)
        sliderScrollView.contentSize.height = headerView.bounds.height
        let childOfScrollView = UIView()
        childOfScrollView.frame.origin = CGPoint(x: 0, y: 0)
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
            imageView.clipsToBounds = true
            imageView.frame = CGRect(origin: viewOrigin, size: viewSize)
            imageView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            imageView.image = item.element
            
            if AppUtility.shared.currentLang == .ar{
                imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }
            
            containerView.addSubview(imageView)
            viewsArray.append(containerView)
            childOfScrollView.addSubview(containerView)
        }
        if AppUtility.shared.currentLang == .ar{
            sliderScrollView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        sliderScrollView.showsHorizontalScrollIndicator = false
        sliderScrollView.bringSubviewToFront(sliderPageControl)
        
    }
}
