//
//  ViewController.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 19/05/21.
//

import UIKit

class StartAppPagerVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var pagerData = [PagerScreensModel]()
    
    let collectionMargin = CGFloat(0)
    let itemSpacing = CGFloat(0)
    var itemHeight = CGFloat(312)
    var itemWidth = CGFloat(0)
    var x = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        registerNib()
        setupCollectionView()
        
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupData(){
        
        pagerData.append(PagerScreensModel(name: LocalizedString.memberName, description: LocalizedString.memberDesc, image: Images.memberImage, color: .pagerBlueColor()))
        pagerData.append(PagerScreensModel(name: LocalizedString.complaintName, description: LocalizedString.complaintDesc, image: Images.complaintImage, color: .pagerGreenColor()))
        pagerData.append(PagerScreensModel(name: LocalizedString.noticeName, description: LocalizedString.noticeDesc, image: Images.noticeImage, color: .pagerOrangeColor()))
        pagerData.append(PagerScreensModel(name: LocalizedString.billName, description: LocalizedString.billDesc, image: Images.billImage, color: .pagerLightBlueColor()))
        DispatchQueue.main.async {
            self.setupPageControl()
            self.collectionView.reloadData()
        }
//        setTimer()
    }
    
    func registerNib(){
        collectionView.register(UINib(nibName: AppIdentifiers.startAppPagerCell, bundle: nil), forCellWithReuseIdentifier: AppIdentifiers.startAppPagerCell)
    }
    
    func setupPageControl(){
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        pageControl.numberOfPages = pagerData.count
    }
    
    
    @IBAction func btnGetStartedTapped(_ sender: UIButton) {
        setRootAsLoginScreen()
    }
    
    func setRootAsLoginScreen() {
        let loginVC = LoginVC.instantiate(from: .login)
        self.navigationController?.viewControllers = [loginVC]
        windowSceneDelegate?.window?.rootViewController = navigationController
        windowSceneDelegate?.window?.makeKeyAndVisible()
    }
    
}

extension StartAppPagerVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pagerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppIdentifiers.startAppPagerCell, for: indexPath) as! StartAppPagerCell
        cell.configureCell(pagerData[indexPath.item])
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth = Float(itemWidth + itemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(collectionView?.contentSize.width ?? 0)
        var newPage = Float(self.pageControl.currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
        self.pageControl.currentPage = Int(newPage)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
    
}

extension StartAppPagerVC {
    
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        itemHeight = self.view.frame.height
        itemWidth = (UIScreen.main.bounds.width - collectionMargin * 2.0)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .horizontal
        collectionView?.collectionViewLayout = layout
        collectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    func setTimer() {
        let _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
        if self.x < self.pagerData.count {
            let indexPath = IndexPath(item: x, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.pageControl.currentPage = x
            self.x = self.x + 1
        } else {
            self.x = 0
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            self.pageControl.currentPage = x
        }
    }
}
