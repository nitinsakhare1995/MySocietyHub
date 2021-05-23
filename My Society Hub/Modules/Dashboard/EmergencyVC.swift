//
//  EmergencyVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit
import FittedSheets

class EmergencyVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNib()
       
    }
    
    func registerNib(){
        tableView.tableFooterView =  UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: AppIdentifiers.emergencyCell, bundle: nil), forCellReuseIdentifier: AppIdentifiers.emergencyCell)
    }

}

extension EmergencyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifiers.emergencyCell, for: indexPath) as! EmergencyCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sheetController = SheetViewController(controller: EmergencyNumbersVC.instantiate(from: .dashboard), sizes: [.fixed(300)])
        self.present(sheetController, animated: true, completion: nil)
    }
    
}
