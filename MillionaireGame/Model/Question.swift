//
//  Question.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 13.05.2021.
//

import Foundation

struct Question {
  
  let question: String
  let answers: [String]
  let correctAnswer: String
  
}

extension Question {
  
  func fiftyPromptShouldHideAt() -> [Int] {
    guard answers.count > 0 else { return [] }
    let abc = answers.enumerated()
      .filter { $1 != correctAnswer }
      .map { $0.offset }
    let randomWrongAnswer = abc.randomElement()!
    return abc.filter { $0 != randomWrongAnswer }
  }
  
  func callFriendShouldHighlightAt() -> [Int] {
    guard answers.count > 0 else { return [] }
    let randomisedMind = Int.random(in: 0...1)
    // Check if friend is smart :]
    let isSmart = randomisedMind == 1
    
    if isSmart {
      return answers
        .enumerated()
        .filter { $1 == correctAnswer }
        .map { $0.offset }
    } else {
      let randomAnswerIndex = answers
        .enumerated()
        .map { $0.offset }
        .randomElement()!
      return [randomAnswerIndex]
    }
  }
  
  func hallHelpPercentResults() -> [Int] {
    guard answers.count > 0 else { return [] }
    let correctAnswerIndex = answers.firstIndex(of: correctAnswer)
    
    let maxPercent = 100
    let correctAnswerPercent = Int.random(in: 30..<95)
    var freePercent = maxPercent - correctAnswerPercent
    let secondPercent = Int.random(in: 1..<freePercent - 2)
    freePercent -= secondPercent
    let thirdPercent = Int.random(in: 1..<freePercent)
    freePercent -= thirdPercent
    let fourthPercent = freePercent
    
    var percentAnswers = [
      secondPercent,
      thirdPercent,
      fourthPercent
    ]
    
    percentAnswers.insert(correctAnswerPercent,
                          at: correctAnswerIndex!)
    return percentAnswers
  }
}
