//
//  QuestionOrderStratagy.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 18.05.2021.
//

import Foundation

protocol QuestionOrderStratagy {
  func reorderQuestions(questions: [Question]) -> [Question]
}

final class StraightQuestionsOrder: QuestionOrderStratagy {
  
  func reorderQuestions(questions: [Question]) -> [Question] {
    questions
  }
  
}

final class ShuffledQuestionsOrder: QuestionOrderStratagy {
  
  func reorderQuestions(questions: [Question]) -> [Question] {
    questions.shuffled()
  }
  
}
