//
//  QuestionBuilder.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 20.05.2021.
//

import Foundation

final class QuestionBuilder {
  private var questions: [Int: String] = [:]
  private var correctAnswer: [Int: String] = [:]
  private var answers: [Int: [String]] = [:]
  
  func question(_ question: String, key: Int) {
    questions[key] = question
  }
  
  func correctAnswer(_ answer: String, key: Int) {
    correctAnswer[key] = answer
  }
  
  func answers(_ answers: String, key: Int) {
    self.answers[key] = answers
      .split(separator: ",")
      .map { String($0).capitalizingFirstLetter() }
  }
  
  func build() -> [Question] {
    let questionKeys = questions.map { $0.key }
    let userQuestions: [Question?] = questionKeys.map { key in
      guard
        let question = questions[key],
        let correctAnswer = correctAnswer[key],
        var answers = answers[key]
      else { return nil }
      let randomIndex = Int.random(in: 0...3)
      answers.insert(correctAnswer, at: randomIndex)
      return Question(question: question,
                      answers: answers,
                      correctAnswer: correctAnswer,
                      userCreated: true)
    }
    return userQuestions.compactMap { $0 }
  }
}
