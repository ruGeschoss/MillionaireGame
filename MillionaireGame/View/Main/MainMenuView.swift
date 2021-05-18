//
//  MainMenuView.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 14.05.2021.
//

import UIKit

protocol MainMenuDelegate: AnyObject {
  func navigate(_ path: NavigationPaths)
  func getLastResult() -> String?
}

final class MainMenuView: UIView {
  
  @IBOutlet weak var lastResult: UILabel!
  
  weak var delegate: MainMenuDelegate?
  
  func reload() {
    lastResult.text = delegate?.getLastResult()
  }
  
  @IBAction func settingsTapped(_ sender: UIButton) {
    delegate?.navigate(.settings)
  }
  
  @IBAction func startGameTapped(_ sender: UIButton) {
    delegate?.navigate(.newGame)
  }
  
  @IBAction func allResultsTapped(_ sender: UIButton) {
    delegate?.navigate(.results)
  }
}
