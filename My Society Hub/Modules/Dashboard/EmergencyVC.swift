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
    
    private var emergencyList = [EmergencyModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
        setupEmergecnyList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Emergency"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    func registerNib(){
        tableView.tableFooterView =  UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: AppIdentifiers.emergencyCell, bundle: nil), forCellReuseIdentifier: AppIdentifiers.emergencyCell)
    }
    
    func setupEmergecnyList(){
        emergencyList.append(EmergencyModel(name: "Police", image: #imageLiteral(resourceName: "policeman"), numbers: ["100","022-22621855"]))
        emergencyList.append(EmergencyModel(name: "Ambulance", image: #imageLiteral(resourceName: "ambulance"), numbers: ["102","1298","022-24308888"]))
        emergencyList.append(EmergencyModel(name: "Fire Fighter", image: #imageLiteral(resourceName: "firefighter"), numbers: ["101","022-23085991","022-23085992"]))
        emergencyList.append(EmergencyModel(name: "Covid Center", image: #imageLiteral(resourceName: "nurse"), numbers: ["011-23978046","011-23971075"]))
        emergencyList.append(EmergencyModel(name: "Blood Bank", image: #imageLiteral(resourceName: "blood_bank"), numbers: ["104","1910","022-22620344","022-23769400","022-22621464",
                                                                                                                            "022-22611648","022-22663560","022-23667811","022-24452222","24939595"]))
        emergencyList.append(EmergencyModel(name: "Child Helpline", image: #imageLiteral(resourceName: "child"), numbers: ["1098"]))
        emergencyList.append(EmergencyModel(name: "Women Helpline", image: #imageLiteral(resourceName: "businesswoman"), numbers: ["022-22633333","022-22620111"]))
        self.tableView.reloadData()
    }
    
}

extension EmergencyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.emergencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifiers.emergencyCell, for: indexPath) as! EmergencyCell
        cell.selectionStyle = .none
        cell.configureCell(emergencyList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = EmergencyNumbersVC.instantiate(from: .dashboard)
        let numbers = emergencyList[indexPath.row].numbers
        controller.numbers = numbers
        let height = (numbers.count*35 + 120)
        let sheetController = SheetViewController(controller: controller, sizes: [.fixed(CGFloat(height))])
        self.present(sheetController, animated: true, completion: nil)
    }
    
}
