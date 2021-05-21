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
  private var currentRoundLabel = UILabel()
  
  private let game = Game.shared
  var onGameEnd: ((Int) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    promptView.delegate = self
    questionView.delegate = self
    answersView.delegate = self
    
    game.startNewGame()
    startNextRound()
    setupCurrentRoundLabel()
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

extension GameVC {
  
  private enum Constants {
    static let dimensions: CGFloat = 50
    static let fontSize: CGFloat = dimensions * 0.8
    static let borderWidth: CGFloat = 2
  }
  
  private func setupCurrentRoundLabel() {
    view.addSubview(currentRoundLabel)
    currentRoundLabel.backgroundColor = .yellow
    currentRoundLabel.textColor = .red
    currentRoundLabel.translatesAutoresizingMaskIntoConstraints = false
    currentRoundLabel.textAlignment = .center
    currentRoundLabel.font = .systemFont(ofSize: Constants.fontSize)
    currentRoundLabel.clipsToBounds = true
    currentRoundLabel.layer.cornerRadius = Constants.dimensions / 2
    currentRoundLabel.layer.borderWidth = Constants.borderWidth
    currentRoundLabel.layer.borderColor = UIColor.red.cgColor
    
    NSLayoutConstraint.activate([
      currentRoundLabel.bottomAnchor.constraint(equalTo: promptView.topAnchor),
      currentRoundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      currentRoundLabel.widthAnchor.constraint(equalToConstant: Constants.dimensions),
      currentRoundLabel.heightAnchor.constraint(equalToConstant: Constants.dimensions)
    ])
    
    game.currentGame?
      .correctAnswers
      .addObserver(currentRoundLabel,
                   removeIfExists: true,
                   options: [.new, .initial]) { [weak self] correctAnswers, _ in
        let currentRound = correctAnswers + 1
        self?.currentRoundLabel.text = currentRound.description
      }
  }
  
}
