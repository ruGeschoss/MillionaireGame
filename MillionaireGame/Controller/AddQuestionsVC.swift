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
  
  private var testArray: [String] = [""]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addAllSubviews()
    setupTable()
    setConstraints()
  }
  
  @objc private func saveButtonTapped() {
    addQuestionsTable.endEditing(true)
    print(#function)
  }
  
  @objc private func addCellTapped() {
    addQuestionsTable.endEditing(true)
    testArray.insert("1", at: 0)
    addQuestionsTable.insertSections(.init(integer: 0), with: .automatic)
  }
  
}

// MARK: - Table DataSource
extension AddQuestionsVC: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    1
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    testArray.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = addQuestionsTable
        .dequeueReusableCell(withIdentifier: AddQuestionCell.reuseID) as? AddQuestionCell
    else { return UITableViewCell() }
    return cell
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
