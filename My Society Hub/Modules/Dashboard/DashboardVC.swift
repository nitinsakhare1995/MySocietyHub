//
//  DashboardVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 22/05/21.
//

import UIKit
import SVProgressHUD

class DashboardVC: UIViewController {
    
    @IBOutlet weak var noticeCollectionView: UICollectionView!
    @IBOutlet weak var noticePageControl: UIPageControl!
    @IBOutlet weak var iconsCollectionView: UICollectionView!
    @IBOutlet weak var operationImagesCollectionView: UICollectionView!
    @IBOutlet weak var servicesImagesCollectionView: UICollectionView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblSocietyName: UILabel!
    
    let noticeCollectionMargin = CGFloat(0)
    let noticeItemSpacing = CGFloat(50)
    var noticeItemHeight = CGFloat(0)
    var noticeItemWidth = CGFloat(0)
    
    let operationCollectionMargin = CGFloat(0)
    let operationItemSpacing = CGFloat(50)
    var operationItemHeight = CGFloat(0)
    var operationItemWidth = CGFloat(0)
    
    private var menuData = [menuItemsModel]()
    var adList = [UserTableModel]()
    var bannerList = [UserTableModel]()
    var noticeList = [NoticeTableModel]()
    var userData: UserTableModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblUserName.text = ""
        lblSocietyName.text = ""
        
        topView.roundCorners([.bottomLeft, .bottomRight], radius: 50)
        
        setupPageControl()
        registerNib()
        setupNoticeCollectionView()
        setupOperationCollectionView()
        setupServicesCollectionView()
        setupMenuData()
        
        getUserData()
        getAdsList()
        getBannersList()
        getNoticeList()
        
        tabBarItem.tag = TabbarItemTag.secondViewConroller.rawValue
    }
    
    func registerNib() {
        noticeCollectionView.delegate = self
        noticeCollectionView.dataSource = self
        noticeCollectionView.register(UINib(nibName: AppIdentifiers.noticeBoardCell, bundle: nil), forCellWithReuseIdentifier: AppIdentifiers.noticeBoardCell)
        noticeCollectionView.register(UINib(nibName: AppIdentifiers.noticeBoardPaymentCell, bundle: nil), forCellWithReuseIdentifier: AppIdentifiers.noticeBoardPaymentCell)
        
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
    }
    
    func setupMenuData(){
        menuData.append(menuItemsModel(name: "Pay now", image: #imageLiteral(resourceName: "debit_card")))
        menuData.append(menuItemsModel(name: "My Account", image: #imageLiteral(resourceName: "my_account")))
        menuData.append(menuItemsModel(name: "Complaint", image: #imageLiteral(resourceName: "complaint")))
        menuData.append(menuItemsModel(name: "Notice", image: #imageLiteral(resourceName: "notice")))
        menuData.append(menuItemsModel(name: "Emergency", image: #imageLiteral(resourceName: "emergency")))
    }
    
    func getUserData(){
        Remote.shared.getUserData { data in
            self.userData = data?.table?.first
            self.lblUserName.text = data?.table?.first?.customerName
            self.lblSocietyName.text = data?.table?.first?.locationName
            UserDefaults.standard.setValue(data?.table?.first?.customerID, forKey: DefaultKeys.UDUserID)

            DispatchQueue.main.async {
                self.noticeCollectionView.reloadData()
            }
        }
    }
    
    func getAdsList(){
        Remote.shared.getAds { data in
            self.adList = data?.table ?? []
            DispatchQueue.main.async {
                self.operationImagesCollectionView.reloadData()
            }
        }
    }
    
    func getBannersList(){
        Remote.shared.getBanners { data in
            self.bannerList = data?.table ?? []
            DispatchQueue.main.async {
                self.servicesImagesCollectionView.reloadData()
            }
        }
    }
    
    func getNoticeList(){
        Remote.shared.getNoticeBoardList{ data in
            self.noticeList = data?.table ?? []
            DispatchQueue.main.async {
                self.noticeCollectionView.reloadData()
                self.noticePageControl.numberOfPages = self.noticeList.count + 1
            }
        }
    }
    
}

extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.noticeCollectionView:
            return self.noticeList.count + 1
        case self.iconsCollectionView:
            return menuData.count
        case self.operationImagesCollectionView:
            return self.adList.count
        case self.servicesImagesCollectionView:
            return self.bannerList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.noticeCollectionView:
            if indexPath.item == 0 {
                let cell = noticeCollectionView.dequeueReusableCell(withReuseIdentifier: AppIdentifiers.noticeBoardPaymentCell, for: indexPath) as! NoticeBoardPaymentCell
                cell.lblAmount.text = "₹ \(self.userData?.outstandingAmount?.description ?? "")"
                cell.payNowBtnTapped = {
                    let vc = PayNowVC.instantiate(from: .dashboard)
                    vc.isFromNavigation = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                return cell
            } else {
                let cell = noticeCollectionView.dequeueReusableCell(withReuseIdentifier: AppIdentifiers.noticeBoardCell, for: indexPath) as! NoticeBoardCell
                cell.configureCell(self.noticeList[indexPath.item - 1])
                cell.downloadBtnTapped = {
                    if let url = self.noticeList[indexPath.item - 1].downloadPath {
                        self.storeAndShare(withURLString: url)
                    }
                }
                cell.readMoreBtnTapped = {
                    if let popupViewController = UIStoryboard(name: Storyboard.noticeComplaint.rawValue, bundle: nil).instantiateViewController(withIdentifier: "NoticeBoardPopUpVC") as? NoticeBoardPopUpVC {
                        popupViewController.modalPresentationStyle = .custom
                        popupViewController.modalTransitionStyle = .crossDissolve
                        popupViewController.data = self.noticeList[indexPath.item - 1]
                        popupViewController.controller = self
                        self.present(popupViewController, animated: true)
                    }
                }
                return cell
            }
        case self.iconsCollectionView:
            let cell = iconsCollectionView.dequeueReusableCell(withReuseIdentifier: AppIdentifiers.operationCell, for: indexPath) as! OperationCell
            cell.configureCell(menuData[indexPath.item])
            return cell
        case self.operationImagesCollectionView:
            let cell = operationImagesCollectionView.dequeueReusableCell(withReuseIdentifier: AppIdentifiers.imageCollectionCell, for: indexPath) as! ImageCollectionCell
            let url = URL(string: adList[indexPath.row].path ?? "")
            cell.imgAd.kf.setImage(with: url)
            return cell
        case self.servicesImagesCollectionView:
            let cell = servicesImagesCollectionView.dequeueReusableCell(withReuseIdentifier: AppIdentifiers.imageCollectionCell, for: indexPath) as! ImageCollectionCell
            let url = URL(string: bannerList[indexPath.row].path ?? "")
            cell.imgAd.kf.setImage(with: url)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView == self.noticeCollectionView {
            
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


    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case self.noticeCollectionView:
            print("Error")
        case self.iconsCollectionView:
            switch self.menuData[indexPath.item].name{
            case "Pay now":
                let vc = PayNowVC.instantiate(from: .dashboard)
                vc.isFromNavigation = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "My Account":
                let vc = MyAccountVC.instantiate(from: .userAccount)
                self.navigationController?.pushViewController(vc, animated: true)
            case "Complaint":
                let vc = ComplaintVC.instantiate(from: .noticeComplaint)
                self.navigationController?.pushViewController(vc, animated: true)
            case "Notice":
                let vc = NoticeVC.instantiate(from: .noticeComplaint)
                self.navigationController?.pushViewController(vc, animated: true)
            case "Emergency":
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
        noticeItemWidth = self.view.frame.width - 140
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
        
        let layout = ZoomAndSnapFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width-130, height: self.operationImagesCollectionView.frame.height)
        operationImagesCollectionView.collectionViewLayout = layout
        operationImagesCollectionView.contentInsetAdjustmentBehavior = .always
        operationImagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        operationImagesCollectionView.showsHorizontalScrollIndicator = false
        operationImagesCollectionView.decelerationRate = .fast
        operationImagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        operationImagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    func setupServicesCollectionView() {
        
        let layout = ZoomAndSnapFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width-130, height: self.servicesImagesCollectionView.frame.height)
        servicesImagesCollectionView.collectionViewLayout = layout
        servicesImagesCollectionView.contentInsetAdjustmentBehavior = .always
        servicesImagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        servicesImagesCollectionView.showsHorizontalScrollIndicator = false
        servicesImagesCollectionView.decelerationRate = .fast
        servicesImagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        servicesImagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
    }
    
}

extension DashboardVC: UIDocumentInteractionControllerDelegate {
    /// If presenting atop a navigation stack, provide the navigation controller in order to animate in a manner consistent with the rest of the platform
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        guard let navVC = self.navigationController else {
            return self
        }
        navVC.navigationBar.tintColor = .darkGray
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        return navVC
    }
}

extension DashboardVC {
    /// This function will set all the required properties, and then provide a preview for the document
    func share(url: URL) {
        let documentInteractionController = UIDocumentInteractionController()
        documentInteractionController.delegate = self
        documentInteractionController.url = url
        documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
        documentInteractionController.name = url.localizedName ?? url.lastPathComponent
        documentInteractionController.presentPreview(animated: true)
    }
    
    /// This function will store your document to some temporary URL and then provide sharing, copying, printing, saving options to the user
    func storeAndShare(withURLString: String) {
        guard let url = URL(string: withURLString) else { return }
        SVProgressHUD.show()
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                SVProgressHUD.dismiss()
                return }
            let tmpURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(response?.suggestedFilename ?? "fileName.png")
            do {
                try data.write(to: tmpURL)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.share(url: tmpURL)
            }
        }.resume()
    }
}
