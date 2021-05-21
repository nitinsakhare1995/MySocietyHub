//
//  StartAppPagerModel.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 21/05/21.
//

import Foundation
import UIKit

class PagerScreensModel {
    
    let name: String
    let description: String
    let image: UIImage
    let color: UIColor
    
    init(name: String, description: String, image: UIImage, color: UIColor) {
        self.name = name
        self.description = description
        self.image = image
        self.color = color
    }
    
}
