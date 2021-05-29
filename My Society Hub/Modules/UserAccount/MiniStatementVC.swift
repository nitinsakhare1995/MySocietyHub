//
//  MiniStatementVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 27/05/21.
//

import UIKit
import SVProgressHUD

class MiniStatementVC: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var fromDateTF: UITextField!
    @IBOutlet weak var toDateTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var fromDate = "From Date"
    var toDate = "To Date"
    
    let toDatePicker = UIDatePicker()
    let fromDatePicker = UIDatePicker()
    
    var data = [MiniStatementTableModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupTextFieldAndDateView()
        registerNib()
        
        tableView.tableFooterView = UIView()
        
        let todaysDate = Date().string(format: "yyyy-MM-dd")
        let earlyDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())
        let lastYearDate =  earlyDate?.getFormattedDate(format: "yyyy-MM-dd") ?? ""
        callApi(toDate: todaysDate, fromDate: lastYearDate)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Mini Statement"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    func setupTextFieldAndDateView(){
        fromDateTF.delegate = self
        toDateTF.delegate = self
        fromDateTF.tintColor = .clear
        toDateTF.tintColor = .clear
        
        fromDateTF.text = fromDate
        toDateTF.text = toDate
        
        showToDatePicker()
        showFromDatePicker()
    }
    
    func registerNib(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: AppIdentifiers.miniStatementCell, bundle: nil), forCellReuseIdentifier: AppIdentifiers.miniStatementCell)
        tableView.register(UINib(nibName: AppIdentifiers.miniStatementHeaderCell, bundle: nil), forCellReuseIdentifier: AppIdentifiers.miniStatementHeaderCell)
    }
    
    func callApi(toDate: String, fromDate: String){
        Remote.shared.getMiniStatement(toDate: toDate, fromDate: fromDate) { data in
            self.data = data?.table ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
}

extension MiniStatementVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifiers.miniStatementHeaderCell, for: indexPath) as!
                MiniStatementHeaderCell
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifiers.miniStatementCell, for: indexPath) as! MiniStatementCell
            cell.selectionStyle = .none
            cell.configureCell(data[indexPath.row-1])
            cell.viewDocumentBtnTapped = {
                guard let docId = self.data[indexPath.row-1].documentID, let docType = self.data[indexPath.row-1].documentTypeCode else { return }
                Remote.shared.getDocumentUrl(type: docType, Id: docId) { data in
                    if let url = data?.downloadpath {
                        self.storeAndShare(withURLString: url)
                    }
                }
            }
            return cell
        }
    }
    
}

extension MiniStatementVC {
    func showToDatePicker(){
        toDatePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            toDatePicker.preferredDatePickerStyle = .wheels
        }
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneTodatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.done, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toDateTF.inputAccessoryView = toolbar
        toDateTF.inputView = toDatePicker
    }
    
    @objc func doneTodatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        toDateTF.text = formatter.string(from: toDatePicker.date)
        self.toDate = formatter.string(from: toDatePicker.date)
        self.view.endEditing(true)
        print(self.toDate)
        print(self.fromDate)
        
        if self.fromDate == "From Date"{
            showSnackBar(with: "Please select from Date", duration: .middle)
        } else {
            callApi(toDate: toDate, fromDate: fromDate)
        }
    }
    
    func showFromDatePicker(){
        fromDatePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            fromDatePicker.preferredDatePickerStyle = .wheels
        }
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneFromdatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.done, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        fromDateTF.inputAccessoryView = toolbar
        fromDateTF.inputView = fromDatePicker
    }
    
    @objc func doneFromdatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        fromDateTF.text = formatter.string(from: fromDatePicker.date)
        self.fromDate = formatter.string(from: fromDatePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}

extension MiniStatementVC: UIDocumentInteractionControllerDelegate {
    /// If presenting atop a navigation stack, provide the navigation controller in order to animate in a manner consistent with the rest of the platform
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        guard let navVC = self.navigationController else {
            return self
        }
        return navVC
    }
}

extension MiniStatementVC {
    /// This function will set all the required properties, and then provide a preview for the document
    func share(url: URL) {
        let documentInteractionController = UIDocumentInteractionController()
        documentInteractionController.delegate = self
        documentInteractionController.url = url
        documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
        documentInteractionController.name = url.localizedName ?? url.lastPathComponent
        documentInteractionController.presentPreview(animated: true)
    }
    
    /// This function will store your document to some temporary URL and then provide sharing, copying, printing, saving options to the user
    func storeAndShare(withURLString: String) {
        guard let url = URL(string: withURLString) else { return }
        SVProgressHUD.show()
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                SVProgressHUD.dismiss()
                return }
            let tmpURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(response?.suggestedFilename ?? "fileName.png")
            do {
                try data.write(to: tmpURL)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.share(url: tmpURL)
            }
        }.resume()
    }
}
