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
    switch path {
    case .newGame:
      guard
        let gameVC = storyboard?
          .instantiateViewController(identifier: "GameVC") as? GameVC
      else { return }
      gameVC.onGameEnd = { [weak self] result in
        self?.previousGameResult = result
      }
      navigationController?.pushViewController(gameVC, animated: true)
    case .results:
      print("Not yet")
    }
  }
  
  func getLastResult() -> String? {
    guard let result = previousGameResult else { return nil }
    return "Результат предыдущей игры: \(result)"
  }
  
}
