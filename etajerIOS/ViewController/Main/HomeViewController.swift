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
import SkeletonView

class HomeViewController: BaseViewController {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var cartProductsCountView: UIView!
    @IBOutlet weak var cartProductsCountLbl: UILabel!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var sliderScrollView: UIScrollView!
    @IBOutlet weak var sliderPageControl: UIPageControl!
    
    
    let viewModel = HomeViewModel()
    var banners: Array<UIImage> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.getHome(parent: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.frame.size.height = AppUtility.shared.screenHeight
        viewModel.getCart()
    }
    
    func registerCell(){
        let nib = UINib(nibName: "CategoryCell", bundle: .main)
        homeTableView.register(nib, forCellReuseIdentifier: "CategoryCell")
        let bannerCellNib = UINib(nibName: "BannerCell", bundle: .main)
        homeTableView.register(bannerCellNib, forCellReuseIdentifier: "BannerCell")
    }
    
    override func configureUI() {
        super.configureUI()
        registerCell()
        configureTableView()
        homeTableView.dataSource = self
        homeTableView.showAnimatedGradientSkeleton()
        sliderScrollView.showAnimatedGradientSkeleton()
        cartProductsCountView.isHidden = true
        
        menuBtn.rx
            .tap
            .subscribe {[weak self] (_) in
                guard let self = self else { return }
                self.openMenu()
        }.disposed(by: bag)
        
        cartBtn.rx
            .tap
            .subscribe { (_) in
                if AppUtility.shared.currentAccessToken != nil {
                    NavigationCoordinator.shared.mainNavigator.navigate(To: .cartViewController)
                } else {
                    self.alertWithCancel(title: "", message: NOT_SIGNIN.localized(), actionTitle: SIGNIN.localized(), completion: { (isLogin) in
                        guard isLogin else { return }
                        NavigationCoordinator.shared.mainNavigator.present(.signInViewController, completion: nil)
                    })
                }
        }.disposed(by: bag)
        
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
        
        didSelectRow()
    }
    
    override func configureData() {
        super.configureData()
        viewModel.output
            .scrollElemnets
            .bind {[unowned self] (adsArr) in
                self.setupScrollView(elements: adsArr)
        }.disposed(by: bag)
        
        viewModel.output
            .cartProductsCount
            .bind {[unowned self] (productCount) in
                if productCount > 0 {
                    self.cartProductsCountLbl.text = "\(productCount) "
                    self.cartProductsCountView.isHidden = false
                } else {
                    self.cartProductsCountView.isHidden = true
                }
        }.disposed(by: bag)
    }
    
    func configureTableView(){
        homeTableView.delegate = nil
        homeTableView.dataSource = nil
        homeTableView.separatorStyle = .none
        viewModel.output
            .homeData
            .bind(to: homeTableView.rx.items){[unowned self] tableView, row, element in
                self.homeTableView.hideSkeleton()
                let indexPath = IndexPath(row: row, section: 0)
                let cell = self.makeCellAt(indexPath: indexPath, byTableView: tableView, element: element)
                return cell
        }.disposed(by: bag)
    }
    
    func makeCellAt(indexPath: IndexPath, byTableView tableView: UITableView, element: HomeViewModel.HomeData) -> UITableViewCell {
        
        guard indexPath.row != 2 else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath) as? BannerCell else {return BannerCell()}
            cell.bannerImg?.contentMode = .scaleAspectFit
            guard let item = (element.data as? [Ads])?.first else {return cell}
            getImageForm(ads: item, to: cell.bannerImg)
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {return CategoryCell()}
        cell.categoryCollectionView.showAnimatedGradientSkeleton()
        
        guard let items = element.data as? [Product]  else {
            let categories = element.data as? [Category]
            let category = categories?.first
            guard let products = category?.products else { return cell }
            cell.categoryId = category?.id
            cell.category = category
            cell.categoryNameLbl.text = category?.name
            cell.moreItemsLbl.text = MORE_ITEMS.localized()
            cell.subscribeOnData()
            cell.configureCategoryCollection()
            cell.categoryItems.onNext([products])
            return cell
        }
        cell.parent = self
        cell.categoryNameLbl.text = element.title?.rawValue.localized()
        cell.moreItemsLbl.text = MORE_ITEMS.localized()
        cell.subscribeOnData()
        cell.configureCategoryCollection()
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
    
    func getImageForm(ads: Ads, to imageView: UIImageView){
        let strUrl = (ads.bannerBaseUrl ?? "") + "/" + (ads.bannerPath ?? "")
        let url = URL(string: strUrl)
        imageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: { (_, _) in
            imageView.showAnimatedSkeleton()
        }) { (_) in
            imageView.hideSkeleton()
        }
    }
    
    func setupScrollView(elements: [Ads]){
        sliderScrollView.subviews.forEach({ $0.removeFromSuperview() })
        sliderPageControl.numberOfPages = elements.count
        sliderScrollView.contentSize.width = (view.bounds.width) * CGFloat(elements.count)
        sliderScrollView.contentSize.height = headerView.bounds.height
        let childOfScrollView = UIView()
        childOfScrollView.frame.origin = CGPoint(x: 0, y: 0)
        sliderScrollView.addSubview(childOfScrollView)
        sliderScrollView.isPagingEnabled = true
        sliderScrollView.bounces = false
        var viewsArray = [UIView]()
        for item in elements.enumerated() {
            let containerView = UIView()
            let scrollWidth = view.bounds.width
            let scrollSize = sliderScrollView.bounds.size
            let containerPoint = CGPoint(x: scrollWidth * CGFloat(item.offset), y: 0)
            containerView.backgroundColor = UIColor.clear
            containerView.frame.origin = containerPoint
            containerView.frame.size.width = view.bounds.width
            containerView.frame.size.height = scrollSize.height
            containerView.tag = item.offset
            
            let viewOrigin = CGPoint(x: 0, y: 0)
            let viewSize = containerView.bounds.size//CGSize(width: AppUtility.shared.screenWidth, height: sliderScrollView.frame.height)
            let imageView = UIImageView()
            
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.frame = CGRect(origin: viewOrigin, size: viewSize)
            imageView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            getImageForm(ads: item.element, to: imageView)
            
            if AppUtility.shared.currentLang == .ar{
                imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }
            
            containerView.addSubview(imageView)
            viewsArray.append(containerView)
            childOfScrollView.addSubview(containerView)
            sliderScrollView.hideSkeleton()
        }
        if AppUtility.shared.currentLang == .ar{
            sliderScrollView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        sliderScrollView.showsHorizontalScrollIndicator = false
        sliderScrollView.bringSubviewToFront(sliderPageControl)
    }
}


extension HomeViewController: SkeletonTableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "CategoryCell"
    }
}
