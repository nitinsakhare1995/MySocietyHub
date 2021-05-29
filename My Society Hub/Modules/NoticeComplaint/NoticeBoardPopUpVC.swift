//
//  NoticeBoardPopUpVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 29/05/21.
//

import UIKit

class NoticeBoardPopUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
    }
    
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
