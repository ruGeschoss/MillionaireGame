//
//  GameAnswersView.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 14.05.2021.
//

import UIKit

protocol GameAnswersDelegate: AnyObject {
  func didSelectAnswer(at index: Int)
  func titleForAnswerButton(at index: Int) -> String?
}

final class GameAnswersView: UIView {
  
  private var answerA = UIButton()
  private var answerB = UIButton()
  private var answerC = UIButton()
  private var answerD = UIButton()
  private var allButtons = [UIButton]()
  
  weak var delegate: GameAnswersDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initAnswerButtons()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    initAnswerButtons()
  }
  
  func reload() {
    allButtons.enumerated().forEach { index, button in
      button.isHidden = false
      button.backgroundColor = .clear
      let title = delegate?
        .titleForAnswerButton(at: index)
        .flatMap { $0 }
      button.setTitle(title, for: .normal)
    }
  }
  
  @objc func didSelectAnswer(_ sender: UIButton) {
    guard let index = allButtons.firstIndex(of: sender) else { return }
    delegate?.didSelectAnswer(at: index)
  }
}

// MARK: Prompt influence
extension GameAnswersView {
  
  func hideButtons(at indicies: [Int]) {
    indicies.forEach { allButtons[$0].isHidden = true }
  }
  
  func highlightButton(at index: [Int]) {
    index.forEach { allButtons[$0].backgroundColor = .cyan }
  }
  
  func showPercentOnButtons(percents: [Int]) {
    percents.enumerated().forEach { buttonIndex, percent in
      let title = delegate?
        .titleForAnswerButton(at: buttonIndex)
        .flatMap { $0 }
      
      guard let title = title else { return }
      let newTitle = "\(title)\n\n\(percent)%"
      allButtons[buttonIndex].setTitle(newTitle, for: .normal)
    }
  }
  
}

// MARK: - Initialisation
extension GameAnswersView {
  
  private func initAnswerButtons() {
    initAnswerA()
    initAnswerB()
    initAnswerC()
    initAnswerD()
  }
  
  private func commonButtonInit(_ button: UIButton) {
    addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.numberOfLines = 0
    button.titleLabel?.textAlignment = .center
    button.addTarget(self, action: #selector(didSelectAnswer(_:)), for: .touchUpInside)
    allButtons.append(button)
    
    NSLayoutConstraint.activate([
      button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
      button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2)
    ])
  }
  
  private func initAnswerA() {
    commonButtonInit(answerA)
    
    NSLayoutConstraint.activate([
      answerA.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      answerA.topAnchor.constraint(equalTo: self.topAnchor)
    ])
  }
  
  private func initAnswerB() {
    commonButtonInit(answerB)
    
    NSLayoutConstraint.activate([
      answerB.leadingAnchor.constraint(equalTo: answerA.trailingAnchor),
      answerB.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      answerB.topAnchor.constraint(equalTo: self.topAnchor)
    ])
  }
  
  private func initAnswerC() {
    commonButtonInit(answerC)
    
    NSLayoutConstraint.activate([
      answerC.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      answerC.topAnchor.constraint(equalTo: answerA.bottomAnchor),
      answerC.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
  
  private func initAnswerD() {
    commonButtonInit(answerD)
    
    NSLayoutConstraint.activate([
      answerD.leadingAnchor.constraint(equalTo: answerC.trailingAnchor),
      answerD.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      answerD.topAnchor.constraint(equalTo: answerB.bottomAnchor),
      answerD.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
}
