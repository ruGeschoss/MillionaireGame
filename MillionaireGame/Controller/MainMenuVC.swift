//
//  MainMenuVC.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 13.05.2021.
//

import UIKit

enum NavigationPaths {
  case results, newGame, settings
}

class MainMenuVC: UIViewController {
  
  @IBOutlet var mainMenu: MainMenuView!
  
  private var previousGameResult: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mainMenu.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    mainMenu.reload()
  }
  
}

extension MainMenuVC: MainMenuDelegate {
  
  func navigate(_ path: NavigationPaths) {
    var destinationPath: UIViewController?
    
    switch path {
    case .newGame:
      guard
        let gameVC = storyboard?
          .instantiateViewController(identifier: "GameVC") as? GameVC
      else { return }
      gameVC.onGameEnd = { [weak self] result in
        self?.previousGameResult = result
      }
      destinationPath = gameVC
    case .results:
      guard
        let resultsVC = storyboard?
          .instantiateViewController(identifier: "ResultsVC") as? ResultsVC
      else { return }
      destinationPath = resultsVC
    case .settings:
      guard
        let settingsVC = storyboard?
          .instantiateViewController(identifier: "SettingsVC") as? SettingsVC
      else { return }
      destinationPath = settingsVC
    }
    
    navigationController?.pushViewController(destinationPath!, animated: true)
  }
  
  func getLastResult() -> String? {
    guard let result = previousGameResult else { return nil }
    return "Результат предыдущей игры: \(result)"
  }
  
}
