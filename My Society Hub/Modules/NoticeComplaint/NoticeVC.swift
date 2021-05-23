//
//  NoticeComplaint.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 22/05/21.
//

import UIKit

class NoticeVC: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
        
    }
    
    func registerNib(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: AppIdentifiers.noticeCell, bundle: nil), forCellWithReuseIdentifier: AppIdentifiers.noticeCell)
    }
    
    
}

extension NoticeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppIdentifiers.noticeCell, for: indexPath) as! NoticeCell
        return cell
    }
    
}

extension NoticeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width-20)/2
        return CGSize(width: width, height: width)
    }
    
}
