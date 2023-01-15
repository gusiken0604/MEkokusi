//
//  SelectNendaiViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/08/06.
//

import UIKit

class SelectNendaiViewController: UIViewController {
    
    var selectedButton = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizVC = segue.destination as! QuizViewController
        quizVC.quizTangen = selectedButton
//        quizVC.quizTangen = selectTag
        // quizVC.tag2 = selectTag
    }
    
    @IBAction private func nendaiButtonAction(sender: UIButton){
        print(sender.tag)
//        selectTag = sender.tag
        performSegue(withIdentifier: "toQuizVC", sender: nil)
    }
    

}
