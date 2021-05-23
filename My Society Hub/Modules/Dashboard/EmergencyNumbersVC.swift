//
//  EmergencyNumbersVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit

class EmergencyNumbersVC: BaseViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
        mainView.roundCorners([.topLeft, .topRight], radius: 40)
        
    }
    
    func registerNib(){
        tableView.tableFooterView =  UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: AppIdentifiers.emergencyNumbersCell, bundle: nil), forCellReuseIdentifier: AppIdentifiers.emergencyNumbersCell)
    }
    
}

extension EmergencyNumbersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifiers.emergencyNumbersCell, for: indexPath) as! EmergencyNumbersCell
        cell.selectionStyle = .none
        return cell
    }
    
}

