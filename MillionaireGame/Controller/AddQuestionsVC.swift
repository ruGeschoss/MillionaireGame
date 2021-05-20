//
//  AddQuestionsVC.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 19.05.2021.
//

import UIKit

final class AddQuestionsVC: UIViewController {
  
  private enum Constants {
    static let tableInsets: UIEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
    static let saveButtonTitle: String = "Сохранить"
    static let addCellButtonImage: UIImage = .init(systemName: "plus")!
    static let separatorHeight: CGFloat = 10
  }
  
  private enum ButtonConstants: CGFloat {
    case minXmaxX = 10
    case interItem = 5
    case maxY = 50
    case width = 0.25
    case height = 0.125
    case cornerRaius = 20
  }
  
  @IBOutlet weak var addQuestionsTable: UITableView!
  private var saveButton: UIButton = {
    let button = UIButton()
    button.setTitle(Constants.saveButtonTitle, for: .normal)
    button.backgroundColor = .red
    button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
    button.layer.cornerRadius = ButtonConstants.cornerRaius.rawValue
    button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    return button
  }()
  private var addCellButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .green
    button.contentMode = .scaleToFill
    button.setImage(Constants.addCellButtonImage, for: .normal)
    button.layer.cornerRadius = ButtonConstants.cornerRaius.rawValue
    button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    button.addTarget(self, action: #selector(addCellTapped), for: .touchUpInside)
    return button
  }()
  private lazy var builder = QuestionBuilder()
  private let game = Game.shared
  private var userQuestions: [Question] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addAllSubviews()
    setupTable()
    setConstraints()
    addGestureRecogniser()
    
    userQuestions = game.getCreatedQuestions()
    userQuestions.isEmpty ? addEmptyCell() : ()
  }
  
  private func addEmptyCell() {
    userQuestions.insert(Question(), at: .zero)
    addQuestionsTable.insertSections([.zero], with: .automatic)
  }
  
  @objc private func saveButtonTapped() {
    addQuestionsTable.endEditing(true)
    let userQuestions = builder.build()
    game.saveCreatedQuestions(questions: userQuestions)
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func addCellTapped() {
    addQuestionsTable.endEditing(true)
    addEmptyCell()
  }
  
  @objc func returnToMainMenu() {
    navigationController?.popViewController(animated: true)
  }
  
}

// MARK: - Cell Delegate
extension AddQuestionsVC: QuestionCellDelegate {
  
  func didSetQuestion(key: Int, question: String) {
    builder.question(question, key: key)
  }
  
  func didSetCorrectAnswer(key: Int, answer: String) {
    builder.correctAnswer(answer, key: key)
  }
  
  func didSetAnswers(key: Int, answers: String) {
    builder.answers(answers, key: key)
  }
  
}

// MARK: - Table DataSource
extension AddQuestionsVC: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    1
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    userQuestions.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = addQuestionsTable
        .dequeueReusableCell(withIdentifier: AddQuestionCell.reuseID) as? AddQuestionCell
    else { return UITableViewCell() }
    
    let question = userQuestions[indexPath.section]
    cell.delegate = self
    cell.configureFields(userQuestion: question)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard
      let cell = cell as? AddQuestionCell,
      userQuestions.count > indexPath.section
    else { return }
    userQuestions[indexPath.section] = cell.cacheTextFields()
  }
  
  func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let questionToDelete = userQuestions[indexPath.section]
      userQuestions.remove(at: indexPath.section)
      game.deleteCreatedQuestion(question: questionToDelete)
      addQuestionsTable.deleteSections([indexPath.section], with: .fade)
    }
  }
  
}

// MARK: - Table Delegate
extension AddQuestionsVC: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView,
                 viewForFooterInSection section: Int) -> UIView? {
    let separator = UIView()
    separator.backgroundColor = .clear
    return separator
  }
  
  func tableView(_ tableView: UITableView,
                 heightForFooterInSection section: Int) -> CGFloat {
    if addQuestionsTable.numberOfSections - 1 > section {
      return Constants.separatorHeight
    } else {
      let tableMaxY = addQuestionsTable.frame.maxY
      let buttonsMinY = saveButton.frame.minY
      return tableMaxY - buttonsMinY + Constants.separatorHeight
    }
  }
  
}
  
  // MARK: - Setup
  extension AddQuestionsVC {
    
    private func addAllSubviews() {
      view.addSubview(saveButton)
      view.addSubview(addCellButton)
    }
    
    private func setupTable() {
      addQuestionsTable.showsVerticalScrollIndicator = false
      addQuestionsTable.dataSource = self
      addQuestionsTable.delegate = self
      addQuestionsTable.separatorStyle = .none
      addQuestionsTable.register(AddQuestionCell.self, forCellReuseIdentifier: AddQuestionCell.reuseID)
    }
    
    private func addGestureRecogniser() {
      let swiper = UIScreenEdgePanGestureRecognizer()
      swiper.edges = .left
      swiper.addTarget(self, action: #selector(returnToMainMenu))
      view.addGestureRecognizer(swiper)
    }
    
  }
  
  // MARK: - Constraints
  extension AddQuestionsVC {
    
    private func setConstraints() {
      constraintTableView()
      constraintSaveButton()
      constraintAddCellButton()
    }
    
    private func constraintTableView() {
      addQuestionsTable.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        addQuestionsTable.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,
                                               constant: Constants.tableInsets.top),
        addQuestionsTable.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,
                                                  constant: -Constants.tableInsets.bottom),
        addQuestionsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: Constants.tableInsets.left),
        addQuestionsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: -Constants.tableInsets.right)
      ])
    }
    
    private func constraintSaveButton() {
      saveButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                           constant: -ButtonConstants.maxY.rawValue),
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                            constant: ButtonConstants.minXmaxX.rawValue),
        saveButton.heightAnchor.constraint(equalTo: view.widthAnchor,
                                           multiplier: ButtonConstants.height.rawValue)
      ])
    }
    
    private func constraintAddCellButton() {
      addCellButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        addCellButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor,
                                               constant: ButtonConstants.interItem.rawValue),
        addCellButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -ButtonConstants.minXmaxX.rawValue),
        addCellButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                              constant: -ButtonConstants.maxY.rawValue),
        addCellButton.heightAnchor.constraint(equalTo: view.widthAnchor,
                                              multiplier: ButtonConstants.height.rawValue),
        addCellButton.widthAnchor.constraint(equalTo: view.widthAnchor,
                                             multiplier: ButtonConstants.height.rawValue)
      ])
    }
  }
