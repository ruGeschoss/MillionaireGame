//
//  MainMenuVC.swift
//  MillionaireGame
//
//  Created by Alexander Andrianov on 13.05.2021.
//

import UIKit

class MainMenuVC: UIViewController {
  
  @IBOutlet weak var resultsButton: UIButton!
  @IBOutlet weak var startButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  @IBAction func tappedResultsButton(_ sender: UIButton) {
  }
  
  @IBAction func tappedStartButton(_ sender: UIButton) {
    let gameVC = storyboard!.instantiateViewController(identifier: "GameVC")
    navigationController?.pushViewController(gameVC, animated: true)
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
