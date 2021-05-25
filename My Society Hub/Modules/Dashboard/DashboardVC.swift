//
//  DashboardVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 22/05/21.
//

import UIKit

class DashboardVC: UIViewController {

    @IBOutlet weak var noticeCollectionView: UICollectionView!
    @IBOutlet weak var noticePageControl: UIPageControl!
    @IBOutlet weak var iconsCollectionView: UICollectionView!
    @IBOutlet weak var operationImagesCollectionView: UICollectionView!
    @IBOutlet weak var servicesImagesCollectionView: UICollectionView!
    
    let noticeCollectionMargin = CGFloat(0)
    let noticeItemSpacing = CGFloat(50)
    var noticeItemHeight = CGFloat(0)
    var noticeItemWidth = CGFloat(0)
    
    let operationCollectionMargin = CGFloat(0)
    let operationItemSpacing = CGFloat(50)
    var operationItemHeight = CGFloat(0)
    var operationItemWidth = CGFloat(0)
    
    private var menuData = [menuItemsModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPageControl()
        registerNib()
        setupNoticeCollectionView()
        setupOperationCollectionView()
        setupServicesCollectionView()
        setupMenuData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    
    func registerNib() {
        noticeCollectionView.delegate = self
        noticeCollectionView.dataSource = self
        noticeCollectionView.register(UINib(nibName: AppIdentifiers.noticeBoardCell, bundle: nil), forCellWithReuseIdentifier: AppIdentifiers.noticeBoardCell)
        
        iconsCollectionView.delegate = self
        iconsCollectionView.dataSource = self
        iconsCollectionView.register(UINib(nibName: AppIdentifiers.operationCell, bundle: nil), forCellWithReuseIdentifier: AppIdentifiers.operationCell)
        
        operationImagesCollectionView.delegate = self
        operationImagesCollectionView.dataSource = self
        operationImagesCollectionView.register(UINib(nibName: AppIdentifiers.imageCollectionCell, bundle: nil), forCellWithReuseIdentifier: AppIdentifiers.imageCollectionCell)
        
        servicesImagesCollectionView.delegate = self
        servicesImagesCollectionView.dataSource = self
        servicesImagesCollectionView.register(UINib(nibName: AppIdentifiers.imageCollectionCell, bundle: nil), forCellWithReuseIdentifier: AppIdentifiers.imageCollectionCell)
        
    }
    
    func setupPageControl(){
        noticePageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        noticePageControl.numberOfPages = 4
    }

    func setupMenuData(){
        menuData.append(menuItemsModel(name: "Pay now", image: #imageLiteral(resourceName: "debit_card")))
        menuData.append(menuItemsModel(name: "My Account", image: #imageLiteral(resourceName: "my_account")))
        menuData.append(menuItemsModel(name: "Complaint", image: #imageLiteral(resourceName: "complaint")))
        menuData.append(menuItemsModel(name: "Notice", image: #imageLiteral(resourceName: "notice")))
        menuData.append(menuItemsModel(name: "Emergency", image: #imageLiteral(resourceName: "emergency")))
    }

}

extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.noticeCollectionView:
            return 4
        case self.iconsCollectionView:
            return menuData.count
        case self.operationImagesCollectionView:
            return 4
        case self.servicesImagesCollectionView:
            return 4
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.noticeCollectionView:
            let cell = noticeCollectionView.dequeueReusableCell(withReuseIdentifier: AppIdentifiers.noticeBoardCell, for: indexPath) as! NoticeBoardCell
            return cell
        case self.iconsCollectionView:
            let cell = iconsCollectionView.dequeueReusableCell(withReuseIdentifier: AppIdentifiers.operationCell, for: indexPath) as! OperationCell
            cell.configureCell(menuData[indexPath.item])
            return cell
        case self.operationImagesCollectionView:
            let cell = operationImagesCollectionView.dequeueReusableCell(withReuseIdentifier: AppIdentifiers.imageCollectionCell, for: indexPath) as! ImageCollectionCell
            return cell
        case self.servicesImagesCollectionView:
            let cell = servicesImagesCollectionView.dequeueReusableCell(withReuseIdentifier: AppIdentifiers.imageCollectionCell, for: indexPath) as! ImageCollectionCell
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth = Float(noticeItemWidth + noticeItemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(noticeCollectionView?.contentSize.width ?? 0)
        var newPage = Float(self.noticePageControl.currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.noticePageControl.currentPage + 1 : self.noticePageControl.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
        self.noticePageControl.currentPage = Int(newPage)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case self.noticeCollectionView:
            print("Error")
        case self.iconsCollectionView:
            switch indexPath.item{
            case 0:
                let vc = PayNowVC.instantiate(from: .dashboard)
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = MyAccountVC.instantiate(from: .userAccount)
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                let vc = ComplaintVC.instantiate(from: .noticeComplaint)
                self.navigationController?.pushViewController(vc, animated: true)
            case 3:
                let vc = NoticeVC.instantiate(from: .noticeComplaint)
                self.navigationController?.pushViewController(vc, animated: true)
            case 4:
                let vc = EmergencyVC.instantiate(from: .dashboard)
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                print("Error")
            }
        case self.operationImagesCollectionView:
            print("Error")
        case self.servicesImagesCollectionView:
            print("Error")
        default:
            print("Error")
        }
    }
    
}

extension DashboardVC {
    
    func setupNoticeCollectionView() {
        let layout: UICollectionViewFlowLayout = ZoomAndSnapFlowLayout()
        noticeItemHeight = self.noticeCollectionView.frame.height - 50
        noticeItemWidth = self.noticeCollectionView.frame.width - 130
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: noticeItemWidth, height: noticeItemHeight)
        layout.headerReferenceSize = CGSize(width: noticeCollectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: noticeCollectionMargin, height: 0)
        layout.minimumLineSpacing = noticeItemSpacing
        layout.scrollDirection = .horizontal
        noticeCollectionView?.collectionViewLayout = layout
        noticeCollectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    func setupOperationCollectionView() {
        let layout: UICollectionViewFlowLayout = ZoomAndSnapFlowLayout()
        operationItemHeight = self.operationImagesCollectionView.frame.height - 50
        operationItemWidth = self.operationImagesCollectionView.frame.width - 130
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: operationItemWidth, height: operationItemHeight)
        layout.headerReferenceSize = CGSize(width: noticeCollectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: noticeCollectionMargin, height: 0)
        layout.minimumLineSpacing = noticeItemSpacing
        layout.scrollDirection = .horizontal
        operationImagesCollectionView?.collectionViewLayout = layout
        operationImagesCollectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    func setupServicesCollectionView() {
        let layout: UICollectionViewFlowLayout = ZoomAndSnapFlowLayout()
        operationItemHeight = self.servicesImagesCollectionView.frame.height - 50
        operationItemWidth = self.servicesImagesCollectionView.frame.width - 130
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: operationItemWidth, height: operationItemHeight)
        layout.headerReferenceSize = CGSize(width: noticeCollectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: noticeCollectionMargin, height: 0)
        layout.minimumLineSpacing = noticeItemSpacing
        layout.scrollDirection = .horizontal
        servicesImagesCollectionView?.collectionViewLayout = layout
        servicesImagesCollectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
    }

}
