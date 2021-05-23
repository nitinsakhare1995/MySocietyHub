//
//  UIStoryboard+Extensions.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 21/05/21.
//

import Foundation
import UIKit

/// Storyboards
enum Storyboard: String {
    case login = "Login"
    case dashboard = "Dashboard"
    case noticeComplaint = "NoticeComplaint"
    case userAccount = "UserAccount"
}

/// Storyboarded
protocol Storyboarded {
    static func instantiate(from storyBoard: Storyboard) -> Self
}

// MARK: - Storyboarded extension to return view controller
extension Storyboarded where Self: UIViewController {
    
    /// Instantiate
    ///
    /// - Parameter storyBoard: Storyboard
    /// - Returns: Returns view controller
    static func instantiate(from storyBoard: Storyboard) -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)
        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]
        // load our storyboard
        let storyboard = UIStoryboard(name: storyBoard.rawValue, bundle: Bundle.main)
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self // swiftlint:disable:this force_cast
    }
    
}
