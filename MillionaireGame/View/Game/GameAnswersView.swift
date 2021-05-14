//
//  GameAnswersView.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 14.05.2021.
//

import UIKit

final class GameAnswersView: UIView {
  
  private let answerLetters = ["A", "B", "C", "D"]
//  private let answerButtons = [UIButton]()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    createButtons()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    createButtons()
  }
  
  private func createButtons() {
    let buttonHeight = ceil(bounds.height / 2)
    let buttonWidth = ceil(bounds.width / 2)
    var buttonX: CGFloat = .zero
    var buttonY: CGFloat = .zero
    
    answerLetters.enumerated().forEach { index, letter in
      buttonX = index % 2 == 0 ? .zero : buttonWidth
      buttonY = index < 2 ? buttonY : buttonHeight
      
      let buttonOrigin = CGPoint(x: buttonX, y: buttonY)
      let buttonSize = CGSize(width: buttonWidth, height: buttonHeight)
      let buttonFrame = CGRect(origin: buttonOrigin, size: buttonSize)
      let button = UIButton(frame: buttonFrame)
      addSubview(button)
      button.setTitle(letter, for: .normal)
      button.setTitleColor(.black, for: .normal)
      button.addTarget(self, action: #selector(didSelectAnswer(_:)), for: .touchUpInside)
    }
  }
  
  @objc func didSelectAnswer(_ sender: UIButton) {
    print(sender.titleLabel?.text)
  }
  
}
