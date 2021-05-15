//
//  GameVC.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 13.05.2021.
//

import UIKit

protocol CurrentGameSession: AnyObject {
  func promptUsed(prompt: GamePrompt)
  func correctAnswer()
  func getNumberOfCurrentRound() -> Int
}

class GameVC: UIViewController {
  
  @IBOutlet weak var gameKeeper: UIImageView! {
    didSet {
      gameKeeper.image = UIImage(named: "gameKeeper")
      gameKeeper.contentMode = .scaleAspectFill
    }
  }
  @IBOutlet weak var promptView: GamePromptView!
  @IBOutlet weak var questionView: GameQuestionView!
  @IBOutlet weak var answersView: GameAnswersView!
  
  weak var session: CurrentGameSession?
  private let dataSource = Game.shared
  var onGameEnd: ((Int) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dataSource.currentGame = .init(dateStarted: Date())
    session = dataSource.currentGame
    
    promptView.delegate = self
    questionView.delegate = self
    answersView.delegate = self
    
    questionView.reload()
    answersView.reload()
  }
  
  private func startNextRound() {
    questionView.reload()
    answersView.reload()
  }
  
  private func finishGame() {
    self.onGameEnd?(dataSource.finishedGameWithResult())
    navigationController?.popViewController(animated: true)
  }
  
}

extension GameVC: GamePromptDelegate {
  
  func didSelectPrompt(_ prompt: GamePrompt) {
    guard let currentRound = session?
            .getNumberOfCurrentRound() else { return }
    let indicies = dataSource
      .usePrompt(prompt: prompt, forRound: currentRound)
    
    switch prompt {
    case .fifty:
      answersView.hideButtons(at: indicies)
    case .call:
      answersView.highlightButton(at: indicies)
    case .hall:
      answersView.showPercentOnButtons(percents: indicies)
    }
    session?.promptUsed(prompt: prompt)
  }
}

extension GameVC: GameQuestionDelegate {
  
  func qustionForCurrentRound() -> String? {
    guard
      let currentRound = session?.getNumberOfCurrentRound(),
      let question = dataSource.getQuestion(forRound: currentRound)
    else { return nil }
    
    return question
  }
  
}

extension GameVC: GameAnswersDelegate {
  
  func titleForAnswerButton(at index: Int) -> String? {
    guard
      let currentRound = session?.getNumberOfCurrentRound(),
      let answers = dataSource.getAnswers(forRound: currentRound)
    else { return nil }
    
    return answers[index]
  }
  
  func didSelectAnswer(at index: Int) {
    guard
      let currentRound = session?.getNumberOfCurrentRound(),
      let answers = dataSource.getAnswers(forRound: currentRound),
      let correctAnswer = dataSource.getCorrectAnswer(forRound: currentRound)
    else { return }
    
    switch answers[index] == correctAnswer {
    case true:
      session?.correctAnswer()
      guard !dataSource.checkIfLastQuestion() else { fallthrough }
      startNextRound()
    case false:
      finishGame()
    }
  }
  
}
