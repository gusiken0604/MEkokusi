//
//  ScoreViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/07/30.
//

import UIKit

class ScoreViewController: UIViewController {
    @IBOutlet var scoreLabel: UILabel!

    var correctCount2 = 0
    
    @objc func rightButtonPressed1(_ sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
        //self.performSegue(withIdentifier: "toScoreVC", sender: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            title = "単元終了"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "単元終了", style: .plain, target: nil, action: nil)
        //self.navigationController?.navigationBar.tintColor = .white
        //UINavigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        //UINavigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        //ナビゲーションバーの右ボタン
        let action = #selector(rightButtonPressed1(_:))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "TOP",style: .plain,target: self,action: action)
        self.navigationItem.setHidesBackButton(true, animated: true)//戻るボタンを消
        
        
//        let action = #selector(rightButtonPressed(_:))
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "TOP",style: .plain,target: self,action: action)
//                self.navigationItem.setHidesBackButton(true, animated: true)//戻るボタンを消す
        scoreLabel.text = "\(correctCount2) 問正解！"
        print("\(correctCount2) 問正解！")
        
        

        // Do any additional setup after loading the view.
    }
    
    
    
//    @objc func rightButtonPressed(_ sender: UIBarButtonItem) {
//
//        self.navigationController?.popToRootViewController(animated: true)
//    }
    
//   @IBAction func toTopButtonAction(_ sender: Any) {
//
//        self.navigationController?.popToRootViewController(animated: true)
//        //self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)//3つ前の画面に戻る
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
