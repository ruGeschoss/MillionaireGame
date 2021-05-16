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
//    navigationController?.popViewController(animated: true)
  }
}
