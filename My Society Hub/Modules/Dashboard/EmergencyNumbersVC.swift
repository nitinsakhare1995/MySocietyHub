//
//  EmergencyNumbersVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit

class EmergencyNumbersVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnCancel: UIButton!
    
    var numbers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
        btnCancel.setImage(#imageLiteral(resourceName: "cancel").maskWithColor(color: .blueBorderColor()), for: .normal)
        
    }
    
    func registerNib(){
        tableView.tableFooterView =  UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: AppIdentifiers.emergencyNumbersCell, bundle: nil), forCellReuseIdentifier: AppIdentifiers.emergencyNumbersCell)
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension EmergencyNumbersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifiers.emergencyNumbersCell, for: indexPath) as! EmergencyNumbersCell
        cell.selectionStyle = .none
        cell.lblNumber.text = numbers[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        callNumber(phoneNumber: numbers[indexPath.row])
    }
    
}

