//
//  BillSlabVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit

class BillSlabVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [SignatoryTableModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
        callBillSlabAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Bill Slab"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    func registerNib(){
        tableView.tableFooterView =  UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: AppIdentifiers.billSlabCell, bundle: nil), forCellReuseIdentifier: AppIdentifiers.billSlabCell)
    }
    
    func callBillSlabAPI(){
        Remote.shared.getBillSlab { data in
            self.data = data?.table ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension BillSlabVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifiers.billSlabCell, for: indexPath) as! BillSlabCell
        cell.selectionStyle = .none
        cell.configureCell(data[indexPath.row])
        return cell
    }
    
}
