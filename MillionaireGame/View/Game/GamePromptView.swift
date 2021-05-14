//
//  GamePromptView.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 14.05.2021.
//

import UIKit

final class GamePromptView: UIView {
  
  private let fiftyPrompt = UIButton()
  private let callFriendPrompt = UIButton()
  private let askHallPrompt = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initPromptView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    initPromptView()
  }
  
  private func initPromptView() {
    initFiftyPrompt()
    initCallFriendPrompt()
    initAskHallPrompt()
  }
  
  private func initFiftyPrompt() {
    addSubview(fiftyPrompt)
    fiftyPrompt.translatesAutoresizingMaskIntoConstraints = false
    fiftyPrompt.titleLabel?.text = ""
    fiftyPrompt.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    
    NSLayoutConstraint.activate([
      fiftyPrompt.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      fiftyPrompt.topAnchor.constraint(equalTo: self.topAnchor),
      fiftyPrompt.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      fiftyPrompt.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3)
    ])
  }
  
  private func initCallFriendPrompt() {
    addSubview(callFriendPrompt)
    callFriendPrompt.translatesAutoresizingMaskIntoConstraints = false
    callFriendPrompt.titleLabel?.text = ""
    callFriendPrompt.setImage(UIImage(systemName: "square.fill"), for: .normal)
    
    NSLayoutConstraint.activate([
      callFriendPrompt.leadingAnchor.constraint(equalTo: fiftyPrompt.trailingAnchor),
      callFriendPrompt.topAnchor.constraint(equalTo: self.topAnchor),
      callFriendPrompt.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      callFriendPrompt.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3)
    ])
  }
  
  private func initAskHallPrompt() {
    addSubview(askHallPrompt)
    askHallPrompt.translatesAutoresizingMaskIntoConstraints = false
    askHallPrompt.titleLabel?.text = ""
    askHallPrompt.setImage(UIImage(systemName: "circle.fill"), for: .normal)
    
    NSLayoutConstraint.activate([
      askHallPrompt.leadingAnchor.constraint(equalTo: callFriendPrompt.trailingAnchor),
      askHallPrompt.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      askHallPrompt.topAnchor.constraint(equalTo: self.topAnchor),
      askHallPrompt.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      askHallPrompt.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3)
    ])
  }
}
