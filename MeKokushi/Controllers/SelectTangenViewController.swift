//
//  SelectTangenViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/07/31.
//

import UIKit
import RealmSwift

class SelectTangenViewController: UIViewController {
    
    

    
    //let quiz = Quiz()
    //var tangen: Results<Quiz>?
    
    var selectTag = 0
    //var tag1: Int?

    
    @IBOutlet weak var quizSelectButton: UIButton!
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
    

}
