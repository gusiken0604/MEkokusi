//
//  SelectTangenViewController.swift
//  MeKokushi
//
//  Created by 具志堅靖 on 2022/07/31.
//

import UIKit

class SelectTangenViewController: UIViewController {
    
    var selectTag = 0
    var tag1: Int?
    
    //
//    let QuizViewControoler = self.storyboard?.instantiateViewController(withIdentifier: "toQuizVC") as! QuizViewController
//    QuizViewController.value = "tag"
//    self.present(QuizViewController, animated: true, completion: nil)
//
    override func viewDidLoad() {
        super.viewDidLoad()
        let UINavigationController = tabBarController?.viewControllers?[1];
        tabBarController?.selectedViewController = UINavigationController;
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizVC = segue.destination as! QuizViewController
        quizVC.selectLevel = selectTag
        
        //quizVC.tag2 = selectTag
        //print(selectTag,"a")
//        if segue.identifier == "toQuizVC" {
//            let tag2 = segue.destination as! QuizViewController
            //tag2.Int = selectTag
//        }
//        let QuizViewController = storyboard?.instantiateViewController(withIdentifier: "toQuizVC") as? QuizViewController
//                                if let QuizViewController = QuizViewController {
//                                    QuizViewController.tag2 = selectTag
//                                    present(QuizViewController,animated: true,completion: nil)
//                                }
    }
    
    @IBAction func tangenButtonAction(sender: UIButton){
        
        

        print(sender.tag)
        selectTag = sender.tag
   

        performSegue(withIdentifier: "toQuizVC", sender: nil)

//        let QuizViewController = storyboard?.instantiateViewController(withIdentifier: "toQuizVC") as? QuizViewController
//                        if let QuizViewController = QuizViewController {
//                            QuizViewController.tag2 = selectTag
//                            present(QuizViewController,animated: true,completion: nil)
//                        }
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
