//
//  ResultViewController.swift
//  MeKokushi
//
//  Created by 具志堅靖 on 2022/08/11.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet var hanteiLabel: UILabel!
    @IBOutlet var mondaiLabel: UILabel!
    @IBOutlet var kaitouLabel: UILabel!
    @IBOutlet var nextquiz: UIButton!
    @IBOutlet var okiniiri: UIButton!
    
    
    var correct = 0 //エラー対策
    var hantei = 0//正誤判定、１が正解
    var kotae = "0" //問題の答え
    var mondai = "0"
    var correctCount1 = 1
    var quizCount1 = 0
    var mondaisuu1 = 0
    var selectLevel1 = 0
    var changeImage = 0
    var mondaiID = "0"
    var mondaiIID = "0"
    var okiniiri1 = "0"//お気に入り登録
    var owari1 = 0
    let touroku:String = "0"
    var fromBookmarkowari1 = 0
    
    
        
    @IBAction func nextbutton(_ sender: Any) {
        if fromBookmarkowari1 == 1{
            //self.performSegue(withIdentifier: "toScoreVC", sender: nil)
            self.performSegue(withIdentifier: "toBookmarkVC", sender: nil)
        } else if owari1 == 1 {
            //self.performSegue(withIdentifier: "toQuizVC1", sender: nil)
            //self.performSegue(withIdentifier: "toBookmarkVC", sender: nil)
            self.performSegue(withIdentifier: "toScoreVC", sender: nil)
        } else {
            self.performSegue(withIdentifier: "toQuizVC1", sender: nil)
        }
    }
    
    

    //ナビゲーションバーの右ボタン
    @objc func rightButtonPressed(_ sender: UIBarButtonItem) {
        //self.navigationController?.popToRootViewController(animated: true)
        self.performSegue(withIdentifier: "toScoreVC", sender: nil)
    }
    
    @IBAction func okiniiri(_ sender: Any) {
        let touroku = UserDefaults.standard.string(forKey: mondaiIID)
        
        print("ボタン押す前\(String(describing: touroku) )")
        
        if touroku == "0" {
            print(mondaiIID)
            okiniiri1 = "1"
            let touroku = "1"
            UserDefaults.standard.set(touroku, forKey: mondaiIID)
            let image = UIImage(systemName: "star.fill")
            let state = UIControl.State.normal
            okiniiri.setImage(image, for: state)
            print("登録\(touroku as Any)")
        } else {
            okiniiri1 = "0"
            let touroku = "0"
            UserDefaults.standard.set(touroku, forKey: mondaiIID)
            let image = UIImage(systemName: "star")
            let state = UIControl.State.normal
            okiniiri.setImage(image, for: state)
            print("解除\(touroku as Any)")
        }
//        UITableView.performBatchUpdates({
//            self.okiniirilist.reloadData()
//        }){(finish) in
//            print("reload完了")
//        }
        //tableView.reloadData()
        //print("お気に入りボタン")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("終わりは\(owari1)")
        if owari1 == 1 {
        nextquiz.setTitle("終了", for: .normal)
        } else if fromBookmarkowari1 == 1{
            nextquiz.setTitle("終了", for: .normal)
        } else {
            
        }
        //print("問題番号\(mondaiID)")
        //mondaiIID = mondaiID
        //print("最初読み込む前\(touroku)")
        let touroku = UserDefaults.standard.string(forKey: mondaiIID)
        print("登録判定\(mondaiIID)")
        
        
    //お気に入りボタン
        if touroku == "0" {
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
        if fromBookmarkowari1 == 1 {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "",style: .plain,target: self,action: action)
            self.navigationItem.setHidesBackButton(true, animated: true)//戻るボタンを消
           // UINavigationController.setNavigationBarHidden(true:)
            //self.navigationItem.setNavigationBarHidden(true, animated: )
            navigationController?.isNavigationBarHidden = true
            
//            override func viewWillAppear(_ animated: Bool){
//                super.viewWillAppear(animated)
//                navigationController?.isNavigationBarHidden = false
            
        } else {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "終了する",style: .plain,target: self,action: action)
        self.navigationItem.setHidesBackButton(true, animated: true)//戻るボタンを消
        }
        
        if hantei == 1{
            hanteiLabel.text = "正解"
        } else {
            hanteiLabel.text = "不正解"
        }
        
        //print(kotae)
        kaitouLabel.text = "正解は\(kotae)番！ "
        
        //print(correctCount1)
        mondaiLabel.text = mondai
        //        // Do any additional setup after loading the view.
    }
    //遷移先の分岐
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //if owari1 == 1 {
//                let scoreVC = segue.destination as! ScoreViewController
//                                scoreVC.correctCount2 = correctCount1
//            } else {
//                let quizVC = segue.destination as! QuizViewController
//                                quizVC.quizCount = quizCount1 + 1//次の問題
//                                quizVC.mondaisuu = mondaisuu1 + 1
//                                print("mondaisuu1は\(mondaisuu1)")
//                                quizVC.selectLevel = selectLevel1
//                                quizVC.correctCount = correctCount1
//            }
            
            if segue.identifier == "toScoreVC" {
            let scoreVC = segue.destination as! ScoreViewController
                scoreVC.correctCount2 = correctCount1
            } else if segue.identifier == "toQuizVC1"{
                let quizVC = segue.destination as! QuizViewController
                quizVC.quizCount = quizCount1 + 1//次の問題
                quizVC.mondaisuu = mondaisuu1 + 1
                print("mondaisuu1は\(mondaisuu1)")
                quizVC.selectLevel = selectLevel1
                quizVC.correctCount = correctCount1

                            }   else {
           }
        }

    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
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
