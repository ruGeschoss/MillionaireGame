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
  private(set) var totalQuestions: Int
  private(set) var currentReward: Int
  
  init() {
    isFiftyPromptEnabled = true
    isCallFriendPromptEnabled = true
    isHallHelpPromptEnabled = true
    correctAnswers = .zero
    currentReward = .zero
    totalQuestions = .zero
  }
  
  func correctAnswer() {
    totalQuestions += 1
    correctAnswers += 1
    // set currentReward based on enum
  }
  
  func wrongAnswer() {
    totalQuestions += 1
  }
}
