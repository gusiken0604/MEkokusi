//
//  SelectTangenViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/07/31.
//

import UIKit

class SelectTangenViewController: UIViewController {
    
    var selectTag = 0
    //var tag1: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        let UINavigationController = tabBarController?.viewControllers?[1];
        tabBarController?.selectedViewController = UINavigationController;

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizVC = segue.destination as! QuizViewController
        quizVC.selectLevel = selectTag
        

    }
    
    @IBAction func tangenButtonAction(sender: UIButton){
        
        //print(sender.currentTitle as Any)

        print(sender.tag)
        selectTag = sender.tag
   

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
