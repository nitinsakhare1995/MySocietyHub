//
//  GlobalHelper.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import Foundation
import TTGSnackbar

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
