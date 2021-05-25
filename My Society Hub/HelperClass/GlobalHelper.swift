//
//  GlobalHelper.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import Foundation
import TTGSnackbar

public func validateEmail(enteredEmail:String) -> Bool {
    let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPredicate.evaluate(with: enteredEmail)
}

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
