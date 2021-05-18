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
  
  private let game = Game.shared
  var onGameEnd: ((Int) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    promptView.delegate = self
    questionView.delegate = self
    answersView.delegate = self
    
    game.startNewGame()
    startNextRound()
  }
  
  private func startNextRound() {
    questionView.reload()
    answersView.reload()
  }
  
  private func finishGame() {
    self.onGameEnd?(game.finishedGameWithResult())
    navigationController?.popViewController(animated: true)
  }
  
}

extension GameVC: GamePromptDelegate {
  
  func didSelectPrompt(_ prompt: GamePrompt) {
    let indicies = game.usePromptOnIndicies(prompt: prompt)
    
    switch prompt {
    case .fifty:
      answersView.hideButtons(at: indicies)
    case .call:
      answersView.highlightButton(at: indicies)
    case .hall:
      answersView.showPercentOnButtons(percents: indicies)
    }
  }
  
}

extension GameVC: GameQuestionDelegate {
  
  func qustionForCurrentRound() -> String? {
    game.getQuestion()
  }
  
}

extension GameVC: GameAnswersDelegate {
  
  func titleForAnswerButton(at index: Int) -> String? {
    guard let titles = game.getAnswers() else { return nil }
    return titles[index]
  }
  
  func didSelectAnswer(at index: Int) {
    let isCorrectAnswer = game.isCorrectAnswer(answerIndex: index)
    let isLastRound = game.isLastQuestion()
    isCorrectAnswer && !isLastRound ? startNextRound() : finishGame()
  }
  
}
