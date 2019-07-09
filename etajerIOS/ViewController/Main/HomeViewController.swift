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
    let banners = [#imageLiteral(resourceName: "baner1"),#imageLiteral(resourceName: "baner2"),#imageLiteral(resourceName: "baner3")]
    
    let categories: [Category] = [Category(title: "احدث المنتجات"),
                                  Category(title: "المزادات"),
                                  Category(title: "بانر"),
                                  Category(title: "الصحة والجمال"),
                                  Category(title: "الجولات والاجهزة اللوحية")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.catrgories.onNext(categories)
        registerCell()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func registerCell(){
        let nib = UINib(nibName: "CategoryCell", bundle: .main)
        homeTableView.register(nib, forCellReuseIdentifier: "CategoryCell")
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
        setupScrollView()
        
        sliderScrollView.rx
            .didEndDecelerating
            .subscribe {[unowned self] (_) in
                if AppUtility.shared.currentLang == .ar {
                    let pageNumber = round(self.sliderScrollView.contentOffset.x / self.sliderScrollView.frame.width)
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
        viewModel.catrgories
            .bind(to: homeTableView.rx.items){ tableView, row, element in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: IndexPath(row: row, section: 0)) as? CategoryCell else {return CategoryCell()}
                guard let items = element.items else {return cell}
                cell.categoryItems = BehaviorSubject<[String]>(value: items)
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
        sliderScrollView.contentSize.width = (self.view.frame.width) * CGFloat(banners.count)
        sliderScrollView.isPagingEnabled = true
        sliderScrollView.bounces = false
        for item in banners.enumerated() {
            let containerView = UIView()
            let scrollWidth = self.view.frame.width
            let scrollSize = sliderScrollView.frame.size
            let containerPoint = CGPoint(x: scrollWidth * CGFloat(item.offset), y: 0)
            containerView.backgroundColor = UIColor.clear
            containerView.frame.origin = containerPoint
            containerView.frame.size.width = self.view.frame.width
            containerView.frame.size.height = scrollSize.height
            
            let viewOrigin = CGPoint(x: 39 , y: 0)
            let viewSize = CGSize(width: AppUtility.shared.screenWidth, height: sliderScrollView.frame.height)
            
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.frame = CGRect(origin: viewOrigin, size: viewSize)
            imageView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            // newsView.newsImg.image = #imageLiteral(resourceName: "contact_unactive")
            imageView.image = item.element
            
            containerView.addSubview(imageView)
            sliderScrollView.addSubview(containerView)
        }
        sliderScrollView.bringSubviewToFront(sliderPageControl)
        if AppUtility.shared.currentLang == .ar{
            sliderPageControl.currentPage = banners.count - 1
        }
    }
    
}
