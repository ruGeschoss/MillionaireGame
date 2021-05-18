//
//  GameSession.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 13.05.2021.
//

import Foundation

final class GameSession {
  
  private(set) var isFiftyPromptEnabled: Bool
  private(set) var isCallFriendPromptEnabled: Bool
  private(set) var isHallHelpPromptEnabled: Bool
  private(set) var correctAnswers: Int
  private(set) var dateStarted: Date
  
  init(dateStarted: Date) {
    self.dateStarted = dateStarted
    isFiftyPromptEnabled = true
    isCallFriendPromptEnabled = true
    isHallHelpPromptEnabled = true
    correctAnswers = .zero
  }
  
}

extension GameSession: CurrentGameSession {
  
  func promptUsed(prompt: GamePrompt) {
    switch prompt {
    case .fifty:
      isFiftyPromptEnabled = false
    case .call:
      isCallFriendPromptEnabled = false
    case .hall:
      isHallHelpPromptEnabled = false
    }
  }
  
  func correctAnswer() {
    correctAnswers += 1
  }
  
  func getNumberOfCurrentRound() -> Int {
    correctAnswers
  }
  
}
