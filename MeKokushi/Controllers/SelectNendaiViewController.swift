//
//  SelectNendaiViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/08/06.
//

import UIKit

class SelectNendaiViewController: UIViewController {
    
    //var selectTag = 0
    var selectedButton = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizVC = segue.destination as! QuizViewController
        quizVC.quizTangen = selectedButton
//        quizVC.quizTangen = selectTag
        //quizVC.tag2 = selectTag
    }
    
    @IBAction func nendaiButtonAction(sender: UIButton){
        print(sender.tag)
//        selectTag = sender.tag
        performSegue(withIdentifier: "toQuizVC", sender: nil)
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
