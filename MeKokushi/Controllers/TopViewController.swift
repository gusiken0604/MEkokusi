//
//  ViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/07/30.
//

import UIKit
import RealmSwift

class TopViewController: UIViewController,UITabBarDelegate{
    
    
    
//let realm = try! Realm()
    let realm = try! Realm(fileURL: URL(string: Bundle.main.path(forResource: "default", ofType: "realm")!)!)
    
    let quiz = Quiz()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //relmデータ削除
//        try! realm.write {
//            realm.deleteAll()
//        }
//
//        quiz.tangen = "医学概論aa２"
//        try! realm.write {
//            realm.add(quiz)
//        }

        let quizResult = realm.objects(Quiz.self)
        print("realmファイル読み込み\(quizResult)")

     
    }

}
