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
  
  private var answers = ["Ответ А", "Ответ B", "Ответ C", "Ответ D"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    promptView.delegate = self
    questionView.delegate = self
    
    answersView.delegate = self
    answersView.reload()
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
    "Are ya winnin SON?"
  }
}

extension GameVC: GameAnswersDelegate {
  func titleForAnswerButton(at index: Int) -> String {
    answers[index]
  }
  
  func didSelectAnswer(at index: Int) {
    print(answers[index])
  }
}
