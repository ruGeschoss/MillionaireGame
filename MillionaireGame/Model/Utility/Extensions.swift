//
//  Extensions.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 19.05.2021.
//

import UIKit

// MARK: - TableViewCell reuseID
extension UITableViewCell: ReusableCell {}

protocol ReusableCell {}

extension ReusableCell where Self: UITableViewCell {
  static var reuseID: String {
    String(describing: self)
  }
}

// MARK: - ViewController storyboardID
extension UIViewController: AccessibleVC {}

protocol AccessibleVC {}

extension AccessibleVC where Self: UIViewController {
  static var storyboardID: String {
    String(describing: self)
  }
}
