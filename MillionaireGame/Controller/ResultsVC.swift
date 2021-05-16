//
//  ResultsVC.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 16.05.2021.
//

import UIKit

final class ResultsVC: UIViewController {
  
  @IBOutlet weak var resultsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    resultsTableView.dataSource = self
    resultsTableView.delegate = self
  }
  
}

extension ResultsVC: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    Game.shared.getAllResults(.none).count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .value2, reuseIdentifier: "Cell")
    let result = Game.shared.getAllResults(.date)[indexPath.row]
    cell.textLabel?.text = "\(result.percent)"
    cell.detailTextLabel?.text = "\(result.dateFinished)"
    cell.selectionStyle = .none
    return cell
  }
  
}

extension ResultsVC: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    navigationController?.popViewController(animated: true)
  }
}
