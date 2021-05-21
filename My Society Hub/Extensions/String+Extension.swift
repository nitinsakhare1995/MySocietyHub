//
//  String+Extension.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 19/05/21.
//

import Foundation

extension String {

    func localized(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }

}
