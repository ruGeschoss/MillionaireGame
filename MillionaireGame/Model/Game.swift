//
//  Game.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 13.05.2021.
//

import Foundation

final class Game {
  
  static let shared = Game()
  
  var currentGame: GameSession?
  
  private init() {}
}

// extension Game {
//  
//  enum Prompt {
//    case fifty, callFriend, hallHelp
//  }
//  
//  func usePrompt(_ prompt: Prompt) {
//    switch prompt {
//    case .fifty:
//      currentGame?.useFiftyPrompt()
//    case .callFriend:
//      currentGame?.useCallFriendPrompt()
//    case .hallHelp:
//      currentGame?.useHallHelpPrompt()
//    }
//  }
//  
// }
