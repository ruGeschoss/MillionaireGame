//
//  +String.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 21.05.2021.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
