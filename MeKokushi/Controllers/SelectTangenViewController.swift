//
//  SelectTangenViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/07/31.
//

import UIKit

class SelectTangenViewController: UIViewController, UITabBarDelegate {
    
    var selectedButton = ""
  
    @IBOutlet private var quizSelectButton: [UIButton]!
    
    let buttonNames = ["医学概論","臨床医学概論","医用電気電子工学","医用機械工学","生体物性材料工学","生体機能代行装置学","医用治療機器学","生体計測装置学","医用機器安全管理学"]

    private func setButtonName() {
        for index in quizSelectButton.indices {
            quizSelectButton[index].setTitle(buttonNames[index], for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       // print("quizResults432\(quizResults)")
        let UINavigationController = tabBarController?.viewControllers?[1];
        tabBarController?.selectedViewController = UINavigationController;
        
        setButtonName()
     }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let quizVC = segue.destination as! QuizViewController

        quizVC.selectedQuizTangen = selectedButton
    }
    
    @IBAction private func tangenButtonAction(sender: UIButton){

    selectedButton = sender.currentTitle ?? ""
        selectQuizTangenCount = 0
        maxSelectTangenQuizCount = 0
        quizCount = 0
        performSegue(withIdentifier: "toQuizVC", sender: nil)
    }
}
