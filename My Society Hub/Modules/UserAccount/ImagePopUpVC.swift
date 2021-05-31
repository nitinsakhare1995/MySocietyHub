//
//  ImagePopUpVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 29/05/21.
//

import UIKit

class ImagePopUpVC: UIViewController {

    @IBOutlet weak var imageShow: UIImageView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var popUpView: UIView!
    
    var imgURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)

        btnCancel.setImage(#imageLiteral(resourceName: "cancel").maskWithColor(color: .blueBorderColor()), for: .normal)
       
        imageShow.kf.setImage(with: URL(string: self.imgURL ?? ""))
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch = touches.first
            if touch?.view != self.popUpView
            { self.dismiss(animated: true, completion: nil) }
        }
    

    @IBAction func btnCancelTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
