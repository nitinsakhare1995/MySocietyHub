//
//  DashboardTabBarVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 22/05/21.
//

import UIKit

enum TabbarItemTag: Int {
    case firstViewController = 101
    case secondViewConroller = 102
    case thirdViewConroller = 103
}

class DashboardTabBarVC: UITabBarController {
    
    var firstTabbarItemImageView: UIImageView!
        var secondTabbarItemImageView: UIImageView!
    var thirdTabbarItemImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectedIndex = 1
        
        delegate = self
        
        let firstItemView = tabBar.subviews.first!
               firstTabbarItemImageView = firstItemView.subviews.first as? UIImageView
               firstTabbarItemImageView.contentMode = .center

               let secondItemView = self.tabBar.subviews[1]
               self.secondTabbarItemImageView = secondItemView.subviews.first as? UIImageView
               self.secondTabbarItemImageView.contentMode = .center

               let thirdItemView = self.tabBar.subviews[2]
               self.thirdTabbarItemImageView = thirdItemView.subviews.first as? UIImageView
               self.thirdTabbarItemImageView.contentMode = .center
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.blueBorderColor()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func animate(_ imageView: UIImageView) {
            UIView.animate(withDuration: 0.1, animations: {
                imageView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            }) { _ in
                UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3.0, options: .curveEaseInOut, animations: {
                    imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: nil)
            }
        }

        override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            guard let tabbarItemTag = TabbarItemTag(rawValue: item.tag) else {
                return
            }

            switch tabbarItemTag {
            case .firstViewController:
                animate(firstTabbarItemImageView)
            case .secondViewConroller:
                animate(secondTabbarItemImageView)
            case .thirdViewConroller:
                animate(thirdTabbarItemImageView)
            }
        }
    
}

extension DashboardTabBarVC: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
          return false // Make sure you want this as false
        }

        if fromView != toView {
          UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }

        return true
    }
}
