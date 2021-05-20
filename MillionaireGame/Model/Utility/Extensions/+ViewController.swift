//
//  +ViewController.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 21.05.2021.
//

import UIKit

extension UIViewController: AccessibleVC {}

protocol AccessibleVC {}

extension AccessibleVC where Self: UIViewController {
  static var storyboardID: String {
    String(describing: self)
  }
}
