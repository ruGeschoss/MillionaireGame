//
//  GamePromptView.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 14.05.2021.
//

import UIKit

enum GamePrompt: CaseIterable {
  case fifty, call, hall
}

protocol GamePromptDelegate: AnyObject {
  func didSelectPrompt(_ prompt: GamePrompt)
}

final class GamePromptView: UIView {
  
  private let fiftyPrompt = UIButton()
  private let callFriendPrompt = UIButton()
  private let askHallPrompt = UIButton()
  private var allButtons = [UIButton]()
  
  weak var delegate: GamePromptDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initPromptView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    initPromptView()
  }
  
  @objc func didSelectPrompt(_ sender: UIButton) {
    guard let index = allButtons.firstIndex(of: sender) else { return }
    let prompt = GamePrompt.allCases[index]
    delegate?.didSelectPrompt(prompt)
    sender.isHidden = true
  }
}

// MARK: - Initialisation
extension GamePromptView {
  
  private func initPromptView() {
    initFiftyPrompt()
    initCallFriendPrompt()
    initAskHallPrompt()
  }
  
  private func commonButtonInit(button: UIButton) {
    addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(didSelectPrompt(_:)), for: .touchUpInside)
    button.titleLabel?.text = ""
    allButtons.append(button)
    
    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: self.topAnchor),
      button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3)
    ])
  }
  
  private func initFiftyPrompt() {
    commonButtonInit(button: fiftyPrompt)
    fiftyPrompt.setImage(UIImage(systemName: "percent"), for: .normal)
    
    NSLayoutConstraint.activate([
      fiftyPrompt.leadingAnchor.constraint(equalTo: self.leadingAnchor)
    ])
  }
  
  private func initCallFriendPrompt() {
    commonButtonInit(button: callFriendPrompt)
    callFriendPrompt.setImage(UIImage(systemName: "phone.fill"), for: .normal)
    
    NSLayoutConstraint.activate([
      callFriendPrompt.leadingAnchor.constraint(equalTo: fiftyPrompt.trailingAnchor)
    ])
  }
  
  private func initAskHallPrompt() {
    commonButtonInit(button: askHallPrompt)
    askHallPrompt.setImage(UIImage(systemName: "person.3.fill"), for: .normal)

    NSLayoutConstraint.activate([
      askHallPrompt.leadingAnchor.constraint(equalTo: callFriendPrompt.trailingAnchor),
      askHallPrompt.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    ])
  }
}
