//
//  ResultViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/08/11.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet var hanteiLabel: UILabel!
    @IBOutlet var mondaiLabel: UILabel!
    @IBOutlet var kaitouLabel: UILabel!
    @IBOutlet var nextQuiz: UIButton!
    @IBOutlet var okiniiri: UIButton!
    
    
    var correct = 0 //エラー対策
    var result = false//正誤判定、１が正解
    var kotae = "0" //問題の答え
    var mondai = "0"
    var correctCount = 1
    var quizCount = 0
    var mondaisuu = 0
    var quizTangen = ""
    var changeImage = 0
    var mondaiID = "0"
   // var okiniiri1 = ""//お気に入り登録
    var lastQuiz = false
    let touroku = 0
   // var fromBookmarkowari1 = 0
    
    
    
    
    @IBAction func nextbutton(_ sender: Any) {
        
//        if fromBookmarkowari1 == 1{
//
//            self.performSegue(withIdentifier: "toBookmarkVC", sender: nil)
//
//        } else
        if lastQuiz == true {

            self.performSegue(withIdentifier: "toScoreVC", sender: nil)

        } else {

            self.performSegue(withIdentifier: "toQuizVC1", sender: nil)
        }
    }
    
    

    //ナビゲーションバーの右ボタン
    @objc func rightButtonPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "toScoreVC", sender: nil)
    }
    
    @IBAction func okiniiri(_ sender: Any) {
        let touroku = UserDefaults.standard.integer(forKey: mondaiID)
        
        //print("ボタン押す前\(String(describing: touroku) )")
        
        if touroku == 0 {
            print(mondaiID)
            //okiniiri1 = "1"
            let touroku = 0
            UserDefaults.standard.set(touroku, forKey: mondaiID)
            let image = UIImage(systemName: "star.fill")
            let state = UIControl.State.normal
            okiniiri.setImage(image, for: state)
            print("登録\(touroku as Any)")
        } else {
            //okiniiri1 = "0"
            let touroku = 0
            UserDefaults.standard.set(touroku, forKey: mondaiID)
            let image = UIImage(systemName: "star")
            let state = UIControl.State.normal
            okiniiri.setImage(image, for: state)
            //print("解除\(touroku as Any)")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let quizViewController = QuizViewController()
//        quizViewController.nextQuiz()
        //quizViewController.judgeNextQuiz()
        
        //print("resultView\(lastQuiz)")
        if lastQuiz == true {
            nextQuiz.setTitle("終了", for: .normal)
        }
//        } else if fromBookmarkowari1 == 1 {
//            nextQuiz.setTitle("終了", for: .normal)
//        } else {
//
//        }
        //print("問題番号\(mondaiID)")
        //mondaiIID = mondaiID
        //print("最初読み込む前\(touroku)")
        let touroku = UserDefaults.standard.integer(forKey: mondaiID)
        //print("登録判定\(mondaiID)")
        
        
    //お気に入りボタン
        if touroku == 0 {
            let image = UIImage(systemName: "star")//お気に入り画像
            let state = UIControl.State.normal//お気に入り画像
            okiniiri.setImage(image, for: state)
        } else {
            let image = UIImage(systemName: "star.fill")
            let state = UIControl.State.normal
            okiniiri.setImage(image, for: state)
        }

        //ナビゲーションバーの右ボタン
        let action = #selector(rightButtonPressed(_:))
//        if fromBookmarkowari1 == 1 {
//            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "",style: .plain,target: self,action: action)
//            self.navigationItem.setHidesBackButton(true, animated: true)//戻るボタンを消
//            
//        } else {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "終了する",style: .plain,target: self,action: action)
       self.navigationItem.setHidesBackButton(true, animated: true)//戻るボタンを消
//        }
        
        if result == true {
            hanteiLabel.text = "正解"
        } else {
            hanteiLabel.text = "不正解"
        }
        
        //print(kotae)
        kaitouLabel.text = "正解は\(kotae)番！ "
        
        mondaiLabel.text = mondai

    }
    //遷移先の分岐
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "toScoreVC" {
                let scoreVC = segue.destination as! ScoreViewController
                scoreVC.correctCount2 = correctCount
            } else if segue.identifier == "toQuizVC1"{
                let quizVC = segue.destination as! QuizViewController
                quizVC.quizCount = quizCount + 1//次の問題
                quizVC.quizNumber = mondaisuu + 1
                print("mondaisuu1は\(mondaisuu)")
                quizVC.quizTangen = quizTangen
                quizVC.correctCount = correctCount
                
            }   else {
            }
        }

    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        //navigationController?.isNavigationBarHidden = false
    }

}
