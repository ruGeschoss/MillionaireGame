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
  private let caretaker = Caretaker<GameResult>()
  
  private var questions: [Question]
  private var results: [GameResult] {
    didSet {
      caretaker.save(results: results)
    }
  }
  
  private init() {
    questions = .init()
    results = caretaker.retrieveResults()
    print(results)
    setQuestions()
  }
}

extension Game {
  
  enum SortType {
    case date, percent, timeSpent
  }
  
  func getAllResults(_ sorted: SortType?) -> [GameResult] {
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
  
  func finishedGameWithResult() -> Int {
    guard let currentGame = currentGame else { return 0 }
    let gameResults = GameResult(currentGame, questions.count, Date())
    results.append(gameResults)
    self.currentGame = nil
    return gameResults.correctAnswers
  }
  
  func usePrompt(prompt: GamePrompt, forRound: Int) -> [Int] {
    switch prompt {
    case .fifty:
      return questions[forRound].fiftyPromptShouldHideAt()
    case .call:
      return questions[forRound].callFriendShouldHighlightAt()
    case .hall:
      return questions[forRound].hallHelpPercentResults()
    }
  }
  
  func getQuestion(forRound: Int) -> String? {
    guard questions.count > forRound else { return nil }
    return questions[forRound].question
  }
  
  func getAnswers(forRound: Int) -> [String]? {
    guard questions.count > forRound else { return nil }
    return questions[forRound].answers
  }
  
  func getCorrectAnswer(forRound: Int) -> String? {
    guard questions.count > forRound else { return nil }
    return questions[forRound].correctAnswer
  }
  
  func checkIfLastQuestion() -> Bool {
    guard let currentGame = currentGame else { return true }
    return questions.count == currentGame.correctAnswers
  }
}

extension Game {
  
  private func setQuestions() {
    questions = [
      Question(
        question: "Белым снегом всё одето - \nЗначит, наступает ...",
        answers: ["Лето", "Осень", "Зима", "Весна"],
        correctAnswer: "Зима"),
      Question(
        question: "Ночью каждое оконце \nСлабо освещает ...",
        answers: ["Фонарный столб", "Луна", "Местный поп", "Солнце"],
        correctAnswer: "Луна"),
      Question(
        question: "Кукарекает спросонок \nМилый, добрый ..",
        answers: ["Котик", "Петух", "Поросёнок", "Медвежонок"],
        correctAnswer: "Петух"),
      Question(
        question: "Под деревом четыре льва, \nОдин ушёл, осталось ...",
        answers: ["Один", "Два", "Три", "Выжить"],
        correctAnswer: "Три"),
      Question(
        question: "Туристы, приезжающие на Майорку, \nобязаны заплатить налог…",
        answers: ["На плавки", "На пальмы", "На солнце", "На песок"],
        correctAnswer: "На солнце"),
      Question(
        question: "Российский мультфильм, удостоенный «Оскара», — это…",
        answers: ["Простоквашино", "Винни-Пух", "Старик и море", "Ну, погоди!"],
        correctAnswer: "Старик и море"),
      Question(
        question: "Какая берёзка стояла во поле?",
        answers: ["Высокая", "Зеленая", "Кудрявая", "Засохшая"],
        correctAnswer: "Кудрявая"),
      Question(
        question: "Сколько лет рыбачил старик из сказки А.С.Пушкина \"Сказка о рыбаке и рыбке?\"",
        answers: ["43", "23", "53", "33"],
        correctAnswer: "33"),
      Question(
        question: "Какому коню в зубы не смотрят?",
        answers: ["Жареному", "Дарёному", "Горем убитому", "С кариесом"],
        correctAnswer: "Дарёному")
    ]
  }
}
