//
//  SignatoryDetailsVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit

class SignatoryDetailsVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
       
    }
    
    func registerNib(){
        tableView.tableFooterView =  UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: AppIdentifiers.signatoryDetailsCell, bundle: nil), forCellReuseIdentifier: AppIdentifiers.signatoryDetailsCell)
    }

}

extension SignatoryDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifiers.signatoryDetailsCell, for: indexPath) as! SignatoryDetailsCell
        cell.selectionStyle = .none
        return cell
    }
    
}
