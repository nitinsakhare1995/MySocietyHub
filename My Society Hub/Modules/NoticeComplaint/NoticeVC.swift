//
//  NoticeComplaint.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 22/05/21.
//

import UIKit
import FittedSheets

class NoticeVC: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data = [NoticeTableModel]()
    
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 2,
        itemHeight: 105,
        minimumInteritemSpacing: 0,
        minimumLineSpacing: 0,
        sectionInset: UIEdgeInsets(top: 6, left: 6, bottom: 0, right: 6)
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.collectionViewLayout = columnLayout
        collectionView?.contentInsetAdjustmentBehavior = .always
        addBarbuttonItem()
        registerNib()
        getNoticeList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Notice List"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    func addBarbuttonItem(){
        let addButton = UIBarButtonItem(image: #imageLiteral(resourceName: "add"), style: .plain, target: self, action: #selector(addNewNotice))//Change your function name and image name here
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func registerNib(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: AppIdentifiers.noticeCell, bundle: nil), forCellWithReuseIdentifier: AppIdentifiers.noticeCell)
    }
    
    func getNoticeList(){
        Remote.shared.getNoticeList(pageSize: 1) { data in
            self.data = data?.table ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc func addNewNotice() {
        let controller = NewNoticeVC.instantiate(from: .noticeComplaint)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension NoticeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppIdentifiers.noticeCell, for: indexPath) as! NoticeCell
        cell.configureCell(data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = NoticeDetailsVC.instantiate(from: .noticeComplaint)
        controller.data = self.data[indexPath.row]
        let sheetController = SheetViewController(controller: controller, sizes: [.marginFromTop(100)])
        self.present(sheetController, animated: true, completion: nil)
    }
    
}
