//
//  SettingsVC.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 18.05.2021.
//

import UIKit

class SettingsVC: UIViewController {
  
  // TODO: Change to tableView?
  @IBOutlet private var settingsView: SettingsView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    settingsView.delegate = self
    
    let swiper = UIScreenEdgePanGestureRecognizer()
    swiper.edges = .left
    swiper.addTarget(self, action: #selector(returnToMainMenu))
    view.addGestureRecognizer(swiper)
  }
  
  @objc func returnToMainMenu() {
    navigationController?.popViewController(animated: true)
  }
  
}

extension SettingsVC: SettingsViewDelegate {
  
  func settingsDidChange(newSettings: Settings) {
    Game.shared.settings = newSettings
  }
  
}
