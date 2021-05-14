//
//  GameQuestionView.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 14.05.2021.
//

import UIKit

final class GameQuestionView: UIView {
  
  private let question = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initQuestionLabel()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    initQuestionLabel()
  }
  
  private func initQuestionLabel() {
    addSubview(question)
    question.translatesAutoresizingMaskIntoConstraints = false
    question.textAlignment = .center
    
    NSLayoutConstraint.activate([
      question.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      question.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      question.topAnchor.constraint(equalTo: self.topAnchor),
      question.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
}
