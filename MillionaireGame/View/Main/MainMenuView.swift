//
//  MainMenuView.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 14.05.2021.
//

import UIKit

protocol MainMenuDelegate: AnyObject {
  func navigate(_ path: NavigationPaths)
}

final class MainMenuView: UIView {
  
  @IBOutlet weak var lastResult: UILabel!
  
  weak var delegate: MainMenuDelegate?
  
  @IBAction func startGameTapped(_ sender: UIButton) {
    delegate?.navigate(.newGame)
  }
  
  @IBAction func allResultsTapped(_ sender: UIButton) {
    delegate?.navigate(.results)
  }
}
