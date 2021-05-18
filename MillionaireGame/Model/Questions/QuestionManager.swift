//
//  QuestionManager.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 18.05.2021.
//

import Foundation

final class QuestionManager {
  
  private var questions: [Question] = []
  private var orderStrategy: QuestionOrderStratagy?
  
  init() {
    questions = loadQuestions()
  }
  
  func setupQuestions(settings: Settings) {
    orderStrategy = settings.shouldShuffleQuestions ?
      ShuffledQuestionsOrder() : StraightQuestionsOrder()
    
    questions = orderStrategy!.reorderQuestions(questions: questions)
  }
  
  func questionForRound(round: Int) -> Question {
    questions[round]
  }
  
  func questionsCount() -> Int {
    questions.count
  }
  
}

// MARK: - Load questions
extension QuestionManager {
  
  // TODO: Need to get questions from JSON
  private func loadQuestions() -> [Question] {
    [
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
