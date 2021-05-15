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
  
  weak var delegate: CurrentGameSession?
  private let dataSource = Game.shared
  var onGameEnd: ((Int) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
    switch prompt {
    case .fifty:
      answersView.hideButtons(at: [1, 2])
    case .call:
      answersView.highlightButton(at: 0)
    case .hall:
      print("Hall is empty :[")
    }
    delegate?.promptUsed(prompt: prompt)
  }
}

extension GameVC: GameQuestionDelegate {
  func qustionForCurrentRound() -> String? {
    guard let currentRound = delegate?
            .getNumberOfCurrentRound() else { return nil }
    return dataSource.getQuestion(forRound: currentRound)
  }
}

extension GameVC: GameAnswersDelegate {
  func titleForAnswerButton(at index: Int) -> String? {
    guard let currentRound = delegate?
            .getNumberOfCurrentRound() else { return nil }
    let answers = dataSource.getAnswers(forRound: currentRound)
    return answers[index]
  }
  
  func didSelectAnswer(at index: Int) {
    guard let currentRound = delegate?
            .getNumberOfCurrentRound() else { return }
    let answers = dataSource.getAnswers(forRound: currentRound)
    let correctAnswer = dataSource.getCorrectAnswer(forRound: currentRound)
    
    if answers[index] == correctAnswer {
      delegate?.correctAnswer()
      startNextRound()
    } else {
      finishGame()
    }
  }
}
