//
//  SettingsView.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 18.05.2021.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
  func settingsDidChange(newSettings: Settings?)
  func getSavedSetting() -> Settings
}

final class SettingsView: UIView {
  
  private enum Constants {
    static let firstSetting = "Перемешивать вопросы"
    static let secondSetting = "Мои вопросы"
  }
  
  @IBOutlet private weak var firstSettingLabel: UILabel! {
    didSet {
      firstSettingLabel.text = Constants.firstSetting
    }
  }
  @IBOutlet private weak var secondSettingLabel: UILabel! {
    didSet {
      secondSettingLabel.text = Constants.secondSetting
    }
  }
  @IBOutlet private weak var firstSettingSwitch: UISwitch!
  @IBOutlet private weak var secondSettingSwitch: UISwitch!
  
  weak var delegate: SettingsViewDelegate?
  private var savedSettings: Settings?
  
  func reload() {
    savedSettings = delegate?.getSavedSetting()
    
    guard let savedSettings = savedSettings else { return }
    firstSettingSwitch.isOn = savedSettings.shouldShuffleQuestions
    secondSettingSwitch.isOn = savedSettings.useCreatedQuestions
  }
 
  @IBAction private func firstSettingSwitchMoved(_ sender: UISwitch) {
    savedSettings?.shouldShuffleQuestions = sender.isOn
    delegate?.settingsDidChange(newSettings: savedSettings)
  }
  
  @IBAction private func secondSettingSwitchMoved(_ sender: UISwitch) {
    savedSettings?.useCreatedQuestions = sender.isOn
    delegate?.settingsDidChange(newSettings: savedSettings)
  }
}
