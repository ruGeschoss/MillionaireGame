//
//  GameResult.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 15.05.2021.
//

import Foundation

struct GameResult: Codable {
  let correctAnswers: Int
  let maxQuestions: Int
  let percent: Int
  let dateStarted: Date
  let dateFinished: Date
  let isFiftyPrompUsed: Bool
  let isCallPrompUsed: Bool
  let isHallPrompUsed: Bool
  
  init(_ session: GameSession, _ maxQuestions: Int, _ time: Date) {
    self.correctAnswers = session.correctAnswers.value
    self.maxQuestions = maxQuestions
    self.dateStarted = session.dateStarted
    self.dateFinished = time
    self.isFiftyPrompUsed = session.isFiftyPromptEnabled
    self.isCallPrompUsed = session.isCallFriendPromptEnabled
    self.isHallPrompUsed = session.isHallHelpPromptEnabled
    
    let percent = Double(session.correctAnswers.value) / Double(maxQuestions) * 100
    self.percent = Int(percent.rounded())
  }
  
  var resultRepresentation: String {
    "\(percent)%, \(correctAnswers)/\(maxQuestions)"
  }
}
