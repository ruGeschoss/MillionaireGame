//
//  AddQuestionCell.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 19.05.2021.
//

import UIKit

final class AddQuestionCell: UITableViewCell {
  
  private enum Constants: String {
    case question = "Вопрос"
    case correctAnswer = "Правильный ответ"
    case answers = "Три неправильных ответа"
    case saveQuestion = "Сохранить"
    case placeholderEnterWord = "Введите"
    
    static let cellCornerRadius: CGFloat = 40
    static let cellBackgroundColor: UIColor = .yellow
    static let insets: UIEdgeInsets = .init(top: 5, left: 20, bottom: 5, right: 20)
    static let labelFont: UIFont = .systemFont(ofSize: 16)
    static let textFieldFont: UIFont = .systemFont(ofSize: 14)
    static let labelHeight: CGFloat = 40
    static let textFieldHeigth: CGFloat = 40
  }
  
  private lazy var questionLabel = createLabel(text: .question)
  private lazy var correctAnswerLabel = createLabel(text: .correctAnswer)
  private lazy var answersLabel = createLabel(text: .answers)
  private lazy var questionTextField = createTextField(text: .question)
  private lazy var correctAnswerTextField = createTextField(text: .correctAnswer)
  private lazy var answersTextField = createTextField(text: .answers)
  private lazy var saveButton = createButton()
  
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
  
  @objc private func saveQuestionTapped() {
    print(#function)
  }
  
  private func setupCell() {
    selectionStyle = .none
    backgroundColor = Constants.cellBackgroundColor
    layer.cornerRadius = Constants.cellCornerRadius
    layer.masksToBounds = true
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
    constraintSaveButton()
  }
  
  private func constraintQuestionLabel() {
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
    NSLayoutConstraint.activate([
      answersTextField.topAnchor.constraint(equalTo: answersLabel.bottomAnchor,
                                            constant: Constants.insets.top),
      answersTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                constant: Constants.insets.left),
      answersTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: -Constants.insets.right),
      answersTextField.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
    ])
  }
  
  private func constraintSaveButton() {
    NSLayoutConstraint.activate([
      saveButton.topAnchor.constraint(equalTo: answersTextField.bottomAnchor,
                                      constant: Constants.insets.top),
      saveButton.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor,
                                          constant: Constants.insets.left),
      saveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                           constant: -Constants.insets.right),
      saveButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                         constant: -Constants.insets.bottom)
    ])
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
    addSubview(saveButton)
  }
  
  private func createButton() -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.textAlignment = .center
    button.titleLabel?.font = Constants.labelFont
    button.setTitle(Constants.saveQuestion.rawValue, for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .red
    button.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
    button.layer.cornerRadius = 10
    button.addTarget(self, action: #selector(saveQuestionTapped), for: .touchUpInside)
    return button
  }
  
  private func createTextField(text: Constants) -> UITextField {
    let textField = UITextField()
    textField.font = Constants.textFieldFont
    textField.placeholder =
      Constants.placeholderEnterWord.rawValue + " " + text.rawValue.lowercased()
    textField.clearButtonMode = .whileEditing
    textField.enablesReturnKeyAutomatically = true
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }
  
  private func createLabel(text: Constants) -> UILabel {
    let label = UILabel()
    label.text = text.rawValue
    label.font = Constants.labelFont
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }
}
