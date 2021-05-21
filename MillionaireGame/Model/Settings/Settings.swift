//
//  Settings.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 18.05.2021.
//

import Foundation

struct Settings: Codable {
  var shouldShuffleQuestions: Bool
  var useCreatedQuestions: Bool
  
  init(shuffle: Bool, useCreatedQuestions: Bool) {
    self.shouldShuffleQuestions = shuffle
    self.useCreatedQuestions = useCreatedQuestions
  }
  
  init() {
    self.shouldShuffleQuestions = false
    self.useCreatedQuestions = true
  }
}

// TODO: Should use Builder
