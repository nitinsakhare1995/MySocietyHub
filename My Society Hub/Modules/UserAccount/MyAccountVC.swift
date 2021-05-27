//
//  MyAccountVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 22/05/21.
//

import UIKit

class MyAccountVC: BaseViewController {

    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var accountList = [menuItemsModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        userView.dropShadow()
        setupAccountList()
        registerNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "ACCOUNT"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    func registerNib(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: AppIdentifiers.myAccountCell, bundle: nil), forCellReuseIdentifier: AppIdentifiers.myAccountCell)
    }
    
    func setupAccountList(){
        accountList.append(menuItemsModel(name: "Mini Statement", image: #imageLiteral(resourceName: "mini_statement")))
        accountList.append(menuItemsModel(name: "Bill Slab", image: #imageLiteral(resourceName: "bill_slab")))
        accountList.append(menuItemsModel(name: "Signatory Details", image: #imageLiteral(resourceName: "man")))
        accountList.append(menuItemsModel(name: "Complaint", image: #imageLiteral(resourceName: "complaint")))
        accountList.append(menuItemsModel(name: "Notice", image: #imageLiteral(resourceName: "emergency")))
        self.tableView.reloadData()
    }

    
}

extension MyAccountVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifiers.myAccountCell, for: indexPath) as! MyAccountCell
        cell.selectionStyle = .none
        cell.configureCell(accountList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.accountList[indexPath.row].name {
        case "Mini Statement":
            let vc = MiniStatementVC.instantiate(from: .userAccount)
            self.navigationController?.pushViewController(vc, animated: true)
        case "Signatory Details":
            let vc = SignatoryDetailsVC.instantiate(from: .userAccount)
            self.navigationController?.pushViewController(vc, animated: true)
        case "Bill Slab":
            let vc = BillSlabVC.instantiate(from: .userAccount)
            self.navigationController?.pushViewController(vc, animated: true)
        case "Complaint":
            let vc = ComplaintVC.instantiate(from: .noticeComplaint)
            self.navigationController?.pushViewController(vc, animated: true)
        case "Notice":
            let vc = NoticeVC.instantiate(from: .noticeComplaint)
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("Error")
        }
    }
    
}
