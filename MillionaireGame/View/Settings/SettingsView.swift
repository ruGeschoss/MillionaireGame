//
//  SettingsView.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 18.05.2021.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
  func settingsDidChange(newSettings: Settings)
}

final class SettingsView: UIView {
  
  private enum Constants {
    static let firstSetting = "Перемешивать вопросы"
  }
  
  @IBOutlet private weak var firstSettingLabel: UILabel! {
    didSet {
      firstSettingLabel.text = Constants.firstSetting
    }
  }
  @IBOutlet private weak var firstSettingSwitch: UISwitch!
  
  weak var delegate: SettingsViewDelegate?
  private var savedSettings = Game.shared.settings
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    firstSettingSwitch.isOn = savedSettings.shouldShuffleQuestions
  }
 
  @IBAction private func firstSettingSwitchMoved(_ sender: UISwitch) {
    let newSettings = Settings.init(shuffle: sender.isOn)
    delegate?.settingsDidChange(newSettings: newSettings)
  }
}
