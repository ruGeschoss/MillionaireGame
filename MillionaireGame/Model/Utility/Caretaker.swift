//
//  Caretaker.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 16.05.2021.
//

import Foundation

final class Caretaker<Object: Codable> {
  
  private let encoder = JSONEncoder()
  private let decoder = JSONDecoder()
  
  private lazy var key: String = {
    String(describing: Object.self)
  }()
  
  func save(_ object: [Object]) {
    do {
      let data = try self.encoder.encode(object)
      // TODO: Save to CoreDate instead
      UserDefaults.standard.set(data, forKey: key)
    } catch {
      print(error)
    }
  }
  
  func retrieveResults() -> [Object] {
    guard
      let data = UserDefaults.standard.data(forKey: key)
    else { return [] }
    
    do {
      return try self.decoder.decode([Object].self, from: data)
    } catch {
      print(error)
      return []
    }
  }
}
