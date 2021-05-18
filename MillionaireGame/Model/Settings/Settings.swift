//
//  Settings.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 18.05.2021.
//

import Foundation

struct Settings {
  var shouldShuffleQuestions: Bool
  
  init(shuffle: Bool) {
    self.shouldShuffleQuestions = shuffle
  }
  
  init() {
    self.shouldShuffleQuestions = false
  }
}

// TODO: Should use Builder
