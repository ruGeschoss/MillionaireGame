//
//  ResultsVC.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 16.05.2021.
//

import UIKit

final class ResultsVC: UIViewController {
  
  @IBOutlet weak var resultsTableView: UITableView!
  
  private lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = .current
    formatter.dateFormat = "HH:mm d MMM yy"
    return formatter
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    resultsTableView.dataSource = self
    resultsTableView.delegate = self
    
    let swiper = UIScreenEdgePanGestureRecognizer()
    swiper.edges = .left
    swiper.addTarget(self, action: #selector(returnToMainMenu))
    view.addGestureRecognizer(swiper)
  }
  
  @objc func returnToMainMenu() {
    navigationController?.popViewController(animated: true)
  }
  
}

extension ResultsVC: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    Game.shared.getAllResults(.none).count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
    let result = Game.shared.getAllResults(.date)[indexPath.row]
    let date = dateFormatter.string(from: result.dateFinished)
    
    cell.textLabel?.text = result.resultRepresentation
    cell.detailTextLabel?.text = date
    cell.selectionStyle = .none
    return cell
  }
  
}

extension ResultsVC: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
//    navigationController?.popViewController(animated: true)
  }
}
