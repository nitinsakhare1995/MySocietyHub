//
//  GlobalHelper.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import Foundation
import TTGSnackbar

public let appName = "My Society Hub"

public func showSnackBar(with message: String, duration: TTGSnackbarDuration) {
    DispatchQueue.main.async {
        let snackBar = TTGSnackbar(message: message, duration: duration)
        snackBar.show()
    }
}

public func callNumber(phoneNumber:String) {

  if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {

    let application:UIApplication = UIApplication.shared
    if (application.canOpenURL(phoneCallURL)) {
        application.open(phoneCallURL, options: [:], completionHandler: nil)
    }
  }
}

public func showDate(createdAt: String, dateFormat: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = dateFormat
    if let date = dateFormatterGet.date(from: createdAt) {
        return dateFormatterPrint.string(from: date)
    } else {
        return ""
    }
}

public func openDeviceSettings(title: String, message: String) {
    let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
    let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    // Prints true
                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
    alertController.addAction(settingsAction)
    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    alertController.addAction(cancelAction)
    alertController.showAlertController()
}

public extension UIAlertController {
    func showAlertController() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}

extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}

public extension UIAlertController {
    func showAlertControllerForceUpdate() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}
