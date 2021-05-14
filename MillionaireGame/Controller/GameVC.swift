//
//  GameVC.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 13.05.2021.
//

import UIKit

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
  
  private var question = "Are ya winnin SON?"
  private var answers = ["Ответ А", "Ответ B", "Ответ C", "Ответ D"]
  private var correctAnswer = "Ответ А"
  private var currentRound = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    promptView.delegate = self
    questionView.delegate = self
    answersView.delegate = self
    
    questionView.reload()
    answersView.reload()
  }
  
  private func checkUserAnswer(_ userAnswer: Int) {
    let answer = answers[userAnswer]
    answer == correctAnswer ? startNextRound() : finishGame()
  }
  
  private func startNextRound() {
    print(#function)
    currentRound += 1
    questionView.reload()
    answersView.reload()
  }
  
  private func finishGame() {
    print(#function)
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
  }
}

extension GameVC: GameQuestionDelegate {
  
  func qustionForCurrentRound() -> String {
    question + String(currentRound)
  }
}

extension GameVC: GameAnswersDelegate {
  func titleForAnswerButton(at index: Int) -> String {
    answers[index]
  }
  
  func didSelectAnswer(at index: Int) {
    print(answers[index])
    checkUserAnswer(index)
  }
}
