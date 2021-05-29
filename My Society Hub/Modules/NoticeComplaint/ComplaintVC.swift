//
//  ComplaintVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit
import FittedSheets

class ComplaintVC: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data = [NoticeTableModel]()
    
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 2,
        itemHeight: 190,
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Complaint List"
        getComplaintList()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    func addBarbuttonItem(){
        let addBtn = UIButton(type: .custom)
        addBtn.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        addBtn.setImage(#imageLiteral(resourceName: "add").maskWithColor(color: .white), for: .normal)
        addBtn.addTarget(self, action: #selector(addNewComplaint), for: .touchUpInside)
        let addBarItem = UIBarButtonItem(customView: addBtn)
        let currWidth = addBarItem.customView?.widthAnchor.constraint(equalToConstant: 25)
        currWidth?.isActive = true
        let currHeight = addBarItem.customView?.heightAnchor.constraint(equalToConstant: 25)
        currHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addBtn)
    }
    
    func registerNib(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: AppIdentifiers.complaintCell, bundle: nil), forCellWithReuseIdentifier: AppIdentifiers.complaintCell)
    }
    
    func getComplaintList(){
        Remote.shared.getComplaintList(pageSize: 1) { data in
            self.data = data?.table ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
    
    @objc func addNewComplaint() {
        let controller = NewComplaintVC.instantiate(from: .noticeComplaint)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ComplaintVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppIdentifiers.complaintCell, for: indexPath) as! ComplaintCell
        cell.configureCell(data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = ComplaintDetailsVC.instantiate(from: .noticeComplaint)
        controller.data = self.data[indexPath.row]
        let sheetController = SheetViewController(controller: controller, sizes: [.marginFromTop(100)])
        self.present(sheetController, animated: true, completion: nil)
    }
    
}
