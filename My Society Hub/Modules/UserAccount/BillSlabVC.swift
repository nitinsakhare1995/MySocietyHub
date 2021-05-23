//
//  BillSlabVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit

class BillSlabVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNib()
    }
    

    func registerNib(){
        tableView.tableFooterView =  UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: AppIdentifiers.billSlabCell, bundle: nil), forCellReuseIdentifier: AppIdentifiers.billSlabCell)
    }

}

extension BillSlabVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifiers.billSlabCell, for: indexPath) as! BillSlabCell
        cell.selectionStyle = .none
        return cell
    }
    
}
