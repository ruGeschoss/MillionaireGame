//
//  Game.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 13.05.2021.
//

import Foundation

final class Game {
  
  static let shared = Game()
  private init() {}
  
  var currentGame: GameSession?
  private let questionManager = QuestionManager()
  private let settingsCaretaker = Caretaker<Settings>()
  private let resultCaretaker = Caretaker<GameResult>()
  
  var settings: Settings {
    get { settingsCaretaker.retrieveResults().first ?? Settings() }
    set { settingsCaretaker.save([newValue]) }
  }
  
  private var results: [GameResult] {
    get { resultCaretaker.retrieveResults() }
    set { resultCaretaker.save(newValue) }
  }
  
}

extension Game {
  
  enum ResultsSortType {
    case date, percent, timeSpent
  }
  
  // TODO: Enable sorting in ResultsVC
  func getAllResults(_ sorted: ResultsSortType?) -> [GameResult] {
    switch sorted {
    case .date:
      return results.sorted(by: { $0.dateFinished > $1.dateFinished })
    case .percent:
      return results.sorted(by: { $0.percent > $1.percent })
    case .timeSpent:
      return results
    case .none:
      return results
    }
  }
  
}

extension Game {
  
  func getCreatedQuestions() -> [Question] {
    questionManager.getCreatedQuestions()
  }
  
  func saveCreatedQuestions(questions: [Question]) {
    questionManager.saveCreatedQuestions(questions: questions)
  }
  
  func deleteCreatedQuestion(question: Question) {
    questionManager.deleteCreatedQuestion(questionToDelete: question)
  }
  
}

extension Game {
  
  func startNewGame() {
    currentGame = .init(dateStarted: Date())
    questionManager.setupQuestions(settings: settings)
  }
  
  func finishedGameWithResult() -> Int {
    guard let currentGame = currentGame else { return 0 }
    
    let questionsCount = questionManager.questionsCount()
    let gameResults = GameResult(currentGame, questionsCount, Date())
    results.append(gameResults)
    self.currentGame = nil
    return gameResults.correctAnswers
  }
  
  func usePromptOnIndicies(prompt: GamePrompt) -> [Int] {
    guard
      let currentRound = currentGame?.getNumberOfCurrentRound()
    else { return [] }
    
    let question = questionManager.questionForRound(round: currentRound)
    currentGame?.promptUsed(prompt: prompt)
    
    switch prompt {
    case .fifty:
      return question.fiftyPromptShouldHideAt()
    case .call:
      return question.callFriendShouldHighlightAt()
    case .hall:
      return question.hallHelpPercentResults()
    }
  }
  
  func getQuestion() -> String? {
    guard
      let currentRound = currentGame?.getNumberOfCurrentRound(),
      questionManager.questionsCount() > currentRound
    else { return nil }
    
    return questionManager
      .questionForRound(round: currentRound)
      .question
  }
  
  func getAnswers() -> [String]? {
    guard
      let currentRound = currentGame?.getNumberOfCurrentRound(),
      questionManager.questionsCount() > currentRound
    else { return nil }
    
    return questionManager
      .questionForRound(round: currentRound)
      .answers
  }
  
  func getCorrectAnswer() -> String? {
    guard
      let currentRound = currentGame?.getNumberOfCurrentRound(),
      questionManager.questionsCount() > currentRound
    else { return nil }
    
    return questionManager
      .questionForRound(round: currentRound)
      .correctAnswer
  }
  
  func isLastQuestion() -> Bool {
    guard
      let correctAnswers = currentGame?.correctAnswers,
      questionManager.questionsCount() == correctAnswers.value
    else { return false }
    
    return true
  }
  
  func isCorrectAnswer(answerIndex: Int) -> Bool {
    guard
      let answers = getAnswers(),
      let correctAnswer = getCorrectAnswer(),
      let currentGame = currentGame
    else { return false }
    
    switch answers[answerIndex] == correctAnswer {
    case true:
      currentGame.correctAnswer()
      return true
    case false:
      return false
    }
  }
  
}
