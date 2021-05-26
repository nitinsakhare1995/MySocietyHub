//
//  SignatoryDetailsVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit

class SignatoryDetailsVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [SignatoryTableModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
        callSignatoryDetailsApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Signatory Details"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    func registerNib(){
        tableView.tableFooterView =  UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: AppIdentifiers.signatoryDetailsCell, bundle: nil), forCellReuseIdentifier: AppIdentifiers.signatoryDetailsCell)
    }
    
    func callSignatoryDetailsApi(){
        Remote.shared.getSignatoryDetails { data in
            self.data = data?.table ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}

extension SignatoryDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifiers.signatoryDetailsCell, for: indexPath) as! SignatoryDetailsCell
        cell.selectionStyle = .none
        cell.configureCell(data[indexPath.row])
        
        cell.callButtonTapped = {
            print("CALL")
        }
        
        cell.emailButtonTapped = {
            print("EMAIL")
        }
        
        return cell
    }
    
}
