//
//  TableViewCellExtension.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 19.01.22.
//

import UIKit

// MARK: - UITableViewCell Extension

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
