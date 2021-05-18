//
//  Observable.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 18.05.2021.
//

import Foundation

struct ObservableOptions: OptionSet, CustomStringConvertible {
  
  static let initial = ObservableOptions(rawValue: 1 << 0)
  static let old = ObservableOptions(rawValue: 1 << 1)
  static let new = ObservableOptions(rawValue: 1 << 2)
  
  var rawValue: Int
  
  init(rawValue: Int) {
    self.rawValue = rawValue
  }
  
  var description: String {
    switch self {
    case .initial:
      return "initial"
    case .old:
      return "old"
    case .new:
      return "new"
    default:
      return "ObservableOptions(rawValue: \(rawValue))"
    }
  }
}

class Observable<Type> {
  
  fileprivate class Callback {
    fileprivate weak var observer: AnyObject?
    fileprivate let options: [ObservableOptions]
    fileprivate let closure: (Type, ObservableOptions) -> Void
    
    fileprivate init(observer: AnyObject,
                     options: [ObservableOptions],
                     closure: @escaping (Type, ObservableOptions) -> Void) {
      self.observer = observer
      self.options = options
      self.closure = closure
    }
  }
  
  // MARK: - Properties
  var value: Type {
    didSet {
      removeNilObserverCallbacks()
      notifyCallbacks(value: oldValue, option: .old)
      notifyCallbacks(value: value, option: .new)
    }
  }
  
  // MARK: - Object Lifecycle
  init(_ value: Type) {
    self.value = value
  }
  
  // MARK: - Managing Observers
  private var callbacks: [Callback] = []
  
  func addObserver(_ observer: AnyObject,
                   removeIfExists: Bool = true,
                   options: [ObservableOptions] = [.new],
                   closure: @escaping (Type, ObservableOptions) -> Void) {
    if removeIfExists {
      removeObserver(observer)
    }
    
    let callback = Callback(observer: observer,
                            options: options,
                            closure: closure)
    callbacks.append(callback)
    
    if options.contains(.initial) {
      closure(value, .initial)
    }
  }
  
  func removeObserver(_ observer: AnyObject) {
    callbacks = callbacks.filter { $0.observer !== observer }
  }
  
  // MARK: - Private
  
  func removeNilObserverCallbacks() {
    callbacks = callbacks.filter { $0.observer != nil }
  }
  
  func notifyCallbacks(value: Type,
                       option: ObservableOptions) {
    let callbacksToNotify = callbacks.filter {
      $0.options.contains(option)
    }
    callbacksToNotify.forEach { $0.closure(value, option) }
  }
}
