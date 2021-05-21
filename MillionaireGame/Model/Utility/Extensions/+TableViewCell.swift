//
//  +TableViewCell.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 21.05.2021.
//

import UIKit

extension UITableViewCell: ReusableCell {}

protocol ReusableCell {}

extension ReusableCell where Self: UITableViewCell {
  static var reuseID: String {
    String(describing: self)
  }
}
