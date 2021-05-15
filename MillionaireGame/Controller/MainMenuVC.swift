//
//  MainMenuVC.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 13.05.2021.
//

import UIKit

enum NavigationPaths {
  case results, newGame
}

class MainMenuVC: UIViewController {
  
  @IBOutlet var mainMenu: MainMenuView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mainMenu.delegate = self
  }
  
}

extension MainMenuVC: MainMenuDelegate {
  
  func navigate(_ path: NavigationPaths) {
    switch path {
    case .newGame:
      guard
        let gameVC = storyboard?
          .instantiateViewController(identifier: "GameVC") as? GameVC
      else { return }
      
      Game.shared.currentGame = .init()
      gameVC.delegate = Game.shared.currentGame
      navigationController?.pushViewController(gameVC, animated: true)
    case .results:
      print("Not yet")
    }
  }
  
}
