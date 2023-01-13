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
        self.navigationController?.popToRootViewController(animated: true)//1番最初に戻る


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            title = "単元終了"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "単元終了", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        //ナビゲーションバーの右ボタン
        let action = #selector(rightButtonPressed1(_:))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "TOP",style: .plain,target: self,action: action)

        scoreLabel.text = "\(correctCount2) 問正解！"
        print("\(correctCount2) 問正解！")

    }


}
