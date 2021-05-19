//
//  AddQuestionCell.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 19.05.2021.
//

import UIKit

private enum Constants: String {
  case question = "Вопрос"
  case correctAnswer = "Правильный ответ"
  case answers = "Три неправильных ответа"
  case placeholderEnterWord = "Введите"
  
  static let cellCornerRadius: CGFloat = 30
  static let cellBackgroundColor: UIColor = .yellow
  static let cellBorderColor: CGColor = UIColor.red.cgColor
  static let cellBorderWidth: CGFloat = 2
  static let insets: UIEdgeInsets = .init(top: 5, left: 20, bottom: 5, right: 20)
  static let labelFont: UIFont = .systemFont(ofSize: 16)
  static let textFieldFont: UIFont = .systemFont(ofSize: 14)
  static let labelHeight: CGFloat = 30
  static let textFieldHeigth: CGFloat = 30
}

final class AddQuestionCell: UITableViewCell {
  
  private lazy var questionLabel = createLabel(text: .question)
  private lazy var correctAnswerLabel = createLabel(text: .correctAnswer)
  private lazy var answersLabel = createLabel(text: .answers)
  private lazy var questionTextField = createTextField(text: .question)
  private lazy var correctAnswerTextField = createTextField(text: .correctAnswer)
  private lazy var answersTextField = createTextField(text: .answers)
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupCell()
    addAllSubviews()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupCell()
    addAllSubviews()
    setConstraints()
  }
  
  private func setupCell() {
    selectionStyle = .none
    backgroundColor = Constants.cellBackgroundColor
    layer.cornerRadius = Constants.cellCornerRadius
    layer.borderWidth = Constants.cellBorderWidth
    layer.borderColor = Constants.cellBorderColor
    layer.masksToBounds = true
  }
  
}

// MARK: - TextField Delegate
extension AddQuestionCell: UITextFieldDelegate {
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let text = textField.text else { return }
    
    var isAcceptable: Bool
    
    switch textField {
    case questionTextField:
      isAcceptable = text.count > 10 && text.last == "?"
    case correctAnswerTextField:
      isAcceptable = text.count > 1
    case answersTextField:
      let answersArray = text.split(separator: ",")
      isAcceptable = answersArray.count == 3
    default:
      return
    }
    textField.textColor = isAcceptable ? .systemGreen : .systemRed
  }
  
}

// MARK: Create subviews
extension AddQuestionCell {
  
  private func addAllSubviews() {
    addSubview(questionLabel)
    addSubview(questionTextField)
    addSubview(correctAnswerLabel)
    addSubview(correctAnswerTextField)
    addSubview(answersLabel)
    addSubview(answersTextField)
  }
  
  private func createTextField(text: Constants) -> UITextField {
    let textField = UITextField()
    textField.font = Constants.textFieldFont
    textField.delegate = self
    textField.contentVerticalAlignment = .top
    textField.placeholder =
      Constants.placeholderEnterWord.rawValue + " " + text.rawValue.lowercased()
    textField.clearButtonMode = .whileEditing
    return textField
  }
  
  private func createLabel(text: Constants) -> UILabel {
    let label = UILabel()
    label.text = text.rawValue
    label.font = Constants.labelFont
    return label
  }
}

// MARK: Constraint subviews
extension AddQuestionCell {
  
  private func setConstraints() {
    constraintQuestionLabel()
    constraintQuestionTextField()
    constraintCorrectAnswerLabel()
    constraintCorrectAnswerTextField()
    constraintAnswersLabel()
    constraintAnswersTextField()
  }
  
  private func constraintQuestionLabel() {
    questionLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      questionLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                         constant: Constants.insets.top),
      questionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                             constant: Constants.insets.left),
      questionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                              constant: -Constants.insets.right),
      questionLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
    ])
  }
  
  private func constraintQuestionTextField() {
    questionTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      questionTextField.topAnchor.constraint(equalTo: questionLabel.bottomAnchor,
                                             constant: Constants.insets.top),
      questionTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                 constant: Constants.insets.left),
      questionTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                  constant: -Constants.insets.right),
      questionTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeigth)
    ])
  }
  
  private func constraintCorrectAnswerLabel() {
    correctAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      correctAnswerLabel.topAnchor.constraint(equalTo: questionTextField.bottomAnchor,
                                              constant: Constants.insets.top),
      correctAnswerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                  constant: Constants.insets.left),
      correctAnswerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                   constant: -Constants.insets.right),
      correctAnswerLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
    ])
  }
  
  private func constraintCorrectAnswerTextField() {
    correctAnswerTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      correctAnswerTextField.topAnchor.constraint(equalTo: correctAnswerLabel.bottomAnchor,
                                                  constant: Constants.insets.top),
      correctAnswerTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                      constant: Constants.insets.left),
      correctAnswerTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                       constant: -Constants.insets.right),
      correctAnswerTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeigth)
    ])
  }
  
  private func constraintAnswersLabel() {
    answersLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      answersLabel.topAnchor.constraint(equalTo: correctAnswerTextField.bottomAnchor,
                                        constant: Constants.insets.top),
      answersLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                            constant: Constants.insets.left),
      answersLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                             constant: -Constants.insets.right),
      answersLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
    ])
  }
  
  private func constraintAnswersTextField() {
    answersTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      answersTextField.topAnchor.constraint(equalTo: answersLabel.bottomAnchor,
                                            constant: Constants.insets.top),
      answersTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                               constant: -Constants.insets.bottom * 2),
      answersTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                constant: Constants.insets.left),
      answersTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: -Constants.insets.right)
    ])
  }
  
}
