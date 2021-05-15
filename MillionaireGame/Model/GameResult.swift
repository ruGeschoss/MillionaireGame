//
//  GameResult.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 15.05.2021.
//

import Foundation

struct GameResult {
  let correctAnswers: Int
  let maxQuestions: Int
  let percent: Int
  let dateStarted: Date
  let dateFinished: Date
  let isFiftyPrompUsed: Bool
  let isCallFPrompUsed: Bool
  let isHallPrompUsed: Bool
  
  init(_ session: GameSession, _ maxQuestions: Int, _ time: Date) {
    self.correctAnswers = session.correctAnswers
    self.maxQuestions = maxQuestions
    self.dateStarted = session.dateStarted
    self.dateFinished = time
    self.isFiftyPrompUsed = session.isFiftyPromptEnabled
    self.isCallFPrompUsed = session.isCallFriendPromptEnabled
    self.isHallPrompUsed = session.isHallHelpPromptEnabled
    
    let percent = Double(session.correctAnswers) / Double(maxQuestions) * 100
    self.percent = Int(percent.rounded())
  }
}
