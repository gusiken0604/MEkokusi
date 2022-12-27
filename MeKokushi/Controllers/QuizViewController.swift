//
//  QuizViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/07/30.
//

import UIKit
import RealmSwift

class QuizViewController: UIViewController {
    
    //let realm = try! Realm(fileURL: URL(string: Bundle.main.path(forResource: "default", ofType: "realm")!)!)
    
    //let quiz = Quiz()
    
    @IBOutlet var quizNumberLabel: UILabel!
    @IBOutlet var quizTextView: UITextView!
    @IBOutlet var answerButton1: UIButton!
    @IBOutlet var answerButton2: UIButton!
    @IBOutlet var answerButton3: UIButton!
    @IBOutlet var answerButton4: UIButton!
    @IBOutlet var answerButton5: UIButton!
    @IBOutlet var judgeImageView: UIImageView!
    @IBOutlet var quizImageView: UIImageView!
    
    var csvArray: [String] = []//CSVを入れる箱
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0//正解カウント
    var selectLevel = 0//SelectTangenViewからの値が入る
    var quizTangen = ""//SelectTangenViewからの値が入る
    var kaigyou = "adf"
    var gazou = "avav"
    var result = 0
    var mondaisuu = 1
    var owari = 0//次の問題があるのか判定
    var resultMondai = "0"//リザルトに表示させる問題文、mondaiに代入
    var resultMondaiID = "0"
    var mondaiID = "0"
    var fromBookmark = 0
    var fromBookmarkowari = 0
    
    
    //var okiniiri = 0
    //ナビゲーションバーの右ボタン
    @objc func rightButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //ナビゲーションバーの右ボタン
        let action = #selector(rightButtonPressed(_:))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "終了する",style: .plain,target: self,action: action)
        self.navigationItem.setHidesBackButton(true, animated: true)//戻るボタンを消す
              
        //print("選択した科目は\(selectLevel)")
        
        
        //csv読み込むブロック
        //csvArray = loadCSV(fileName: "quiz\(selectLevel)")//色々なcsvを選択
        csvArray = loadCSV(fileName: "quiz0")//quiz0.csv固定
        //csvArray.shuffle()//問題をシャッフル
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        
        //終わり判定
        if quizCount + 1  < csvArray.count {
        } else {
            owari = 1
        }
        //var quizTangen = quizArray[7]
        print("変数クイズ単元は\(quizTangen)")
        print("quizArray[7]は\(quizArray[10])")
        if quizArray[7] == quizTangen {
       // if Int(quizTangen) == selectLevel {
         //if Int(quizArray[7]) == selectLevel {
            quizNumberLabel.text = "第\(mondaisuu)問"
            //問題分岐
            //問題テキスト
            kaigyou = quizArray[0].replacingOccurrences(of: "　", with: "\n")
             //quizTextView.text = quizArray[0].replacingOccurrences(of: "　", with: "\n")
            resultMondai = quizArray[0]
            resultMondaiID = quizArray[10]
            quizTextView.text = kaigyou
            //print(quizArray[8])
            gazou = quizArray[8]
            quizImageView.image = UIImage(named: gazou)
            //owari = 1
            //print("ここかあああ？")

        } else {
            //owari = 1
            //print("ああああああああああああ")
          nextQuiz()
        }
        
     
        

        //answerButton1.frame = CGRect(height:80)
        
        answerButton1.setTitle(quizArray[1],for: .normal)
        answerButton2.setTitle(quizArray[2],for: .normal)
        answerButton3.setTitle(quizArray[3],for: .normal)
        answerButton4.setTitle(quizArray[4],for: .normal)
        answerButton5.setTitle(quizArray[5],for: .normal)

        //ボタン文字色
        answerButton1.setTitleColor(UIColor.black,for: .normal)
        answerButton2.setTitleColor(UIColor.black,for: .normal)
        answerButton3.setTitleColor(UIColor.black,for: .normal)
        answerButton4.setTitleColor(UIColor.black,for: .normal)
        answerButton5.setTitleColor(UIColor.black,for: .normal)
        //ボタン枠
        answerButton1.layer.borderWidth = 2
        answerButton2.layer.borderWidth = 2
        answerButton3.layer.borderWidth = 2
        answerButton4.layer.borderWidth = 2
        answerButton5.layer.borderWidth = 2
        //ボタン枠色
        answerButton1.layer.borderColor = UIColor(red: 252/255, green: 204/255, blue: 143/255, alpha: 1.0).cgColor
        answerButton2.layer.borderColor = UIColor(red: 252/255, green: 204/255, blue: 143/255, alpha: 1.0).cgColor
        answerButton3.layer.borderColor = UIColor(red: 252/255, green: 204/255, blue: 143/255, alpha: 1.0).cgColor
        answerButton4.layer.borderColor = UIColor(red: 252/255, green: 204/255, blue: 143/255, alpha: 1.0).cgColor
        answerButton5.layer.borderColor = UIColor(red: 252/255, green: 204/255, blue: 143/255, alpha: 1.0).cgColor

        answerButton1.titleLabel?.adjustsFontSizeToFitWidth = true
        answerButton2.titleLabel?.adjustsFontSizeToFitWidth = true
        answerButton3.titleLabel?.adjustsFontSizeToFitWidth = true
        answerButton4.titleLabel?.adjustsFontSizeToFitWidth = true
        answerButton5.titleLabel?.adjustsFontSizeToFitWidth = true

        answerButton1.titleLabel!.numberOfLines = 2
        answerButton2.titleLabel!.numberOfLines = 2
        answerButton3.titleLabel!.numberOfLines = 2
        answerButton4.titleLabel!.numberOfLines = 2
        answerButton5.titleLabel!.numberOfLines = 2
    }
    
    //Score画面の変数correctに代入される
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as! ResultViewController//エラー対策
       
        resultVC.hantei = result
        resultVC.kotae = quizArray[6]
        resultVC.mondai = resultMondai
        resultVC.correctCount1 = correctCount
        resultVC.quizCount1 = quizCount
        resultVC.mondaisuu1 = mondaisuu
        resultVC.selectLevel1 = selectLevel
        resultVC.okiniiri1 = quizArray[9]
        resultVC.mondaiID = quizArray[10]
        resultVC.mondaiIID = resultMondaiID
        resultVC.owari1 = owari//次の問題があるのか判定
        resultVC.fromBookmarkowari1 = fromBookmarkowari
    }
    
    
    
    //ボタンを押したときに呼ばれる
    @IBAction func btnAction(sender:UIButton){
        //print(sender.currentTitle!)
        //owari = 1
        if owari == 0 {
        quizCount = quizCount + 1
        quizArray = csvArray[quizCount].components(separatedBy:",")
        //owari = 1
        quizCount = quizCount - 1
//        if quizCount < csvArray.count {
//            quizArray = csvArray[quizCount].components(separatedBy:",")
//        if Int(quizArray[7]) != selectLevel {
//            print("配列ナナ\(quizArray[7])")
//            print("セレクトレベル\(selectLevel)")
////            owari = 1
////            quizCount = quizCount - 1
//        } else {
////            performSegue(withIdentifier: "toResultVC", sender: nil)
//            quizCount = quizCount - 1
//        }
//
        if sender.tag == Int(quizArray[6]){
            correctCount += 1
            print("スコア:\(correctCount)")
            result = 1
            print("正解")
            judgeImageView.image = UIImage(named: "correct")
        } else {
            
            print("不正解")
            judgeImageView.image = UIImage(named: "incorrect")
        }
        //print("スコア:\(correctCount)")
        judgeImageView.isHidden = false//２回目に表示させる
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        answerButton5.isEnabled = false
        //0.5秒後に非表示
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.judgeImageView.isHidden = true
            self.answerButton1.isEnabled = true
            self.answerButton2.isEnabled = true
            self.answerButton3.isEnabled = true
            self.answerButton4.isEnabled = true
            self.answerButton5.isEnabled = true
            self.performSegue(withIdentifier: "toResultVC", sender: nil)//リザルト画面へ
            }
            
        }else{
            if sender.tag == Int(quizArray[6]){
                correctCount += 1
                print("スコア:\(correctCount)")
                result = 1
                print("正解")
                judgeImageView.image = UIImage(named: "correct")
            } else {
                
                print("不正解")
                judgeImageView.image = UIImage(named: "incorrect")
            }
            //print("スコア:\(correctCount)")
            judgeImageView.isHidden = false//２回目に表示させる
            answerButton1.isEnabled = false
            answerButton2.isEnabled = false
            answerButton3.isEnabled = false
            answerButton4.isEnabled = false
            answerButton5.isEnabled = false
            //0.5秒後に非表示
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.judgeImageView.isHidden = true
                self.answerButton1.isEnabled = true
                self.answerButton2.isEnabled = true
                self.answerButton3.isEnabled = true
                self.answerButton4.isEnabled = true
                self.answerButton5.isEnabled = true
                self.performSegue(withIdentifier: "toResultVC", sender: nil)//リザルト画面へ
                }
        }
        
    }
        
    
    //次の問題を表示させるブロック
    func nextQuiz(){
        switch fromBookmark{
        case 1 :print("ブックマークから\(mondaiID)")
            owari = 1//ブックマークからだと１問で終了
            fromBookmarkowari = 1//ブックマークからだと１問で終了
            if quizCount < csvArray.count {
                quizArray = csvArray[quizCount].components(separatedBy:",")
//                if quizCount + 1  < csvArray.count {
//                    //print("てst")
//                } else{
//                    owari = 1
//                    //print("手st２")
//                }

                if quizArray[10] == mondaiID {
                    quizNumberLabel.text = "第\(mondaisuu)問"

                    //quizTextView.text = quizArray[0]
                    kaigyou = quizArray[0].replacingOccurrences(of: "　", with: "\n")
                    quizTextView.text = kaigyou
                    resultMondai = quizArray[0]//test
                    resultMondaiID = quizArray[10]

                    gazou = quizArray[8]
                    quizImageView.image = UIImage(named: gazou)
//                    quizCount += 1
                    
                } else {
                    quizCount += 1
                    print("あああああ11")
                    //owari = 1
                    nextQuiz()
                    //performSegue(withIdentifier: "toResultVC", sender: nil)
                }

                answerButton1.setTitle(quizArray[1], for: .normal)
                answerButton2.setTitle(quizArray[2], for: .normal)
                answerButton3.setTitle(quizArray[3], for: .normal)
                answerButton4.setTitle(quizArray[4], for: .normal)
                answerButton5.setTitle(quizArray[5], for: .normal)
            } else {
                print("うううう")
                //performSegue(withIdentifier: "toScoreVC", sender: nil)
                performSegue(withIdentifier: "toResultVC", sender: nil)
            }
            
            
       default:
        

        quizCount += 1
        print("クイズ問題番号\(mondaiID)")
        print("セルの移動先a\(quizCount)")
//        print("123123123123")
        if quizCount < csvArray.count {
            quizArray = csvArray[quizCount].components(separatedBy:",")
            if quizArray[7] == quizTangen {
            //if Int(quizArray[7]) == selectLevel {
                quizNumberLabel.text = "第\(mondaisuu)問"

                //quizTextView.text = quizArray[0]
                kaigyou = quizArray[0].replacingOccurrences(of: "　", with: "\n")
                quizTextView.text = kaigyou
                resultMondai = quizArray[0]//test
                resultMondaiID = quizArray[10]

                gazou = quizArray[8]
                quizImageView.image = UIImage(named: gazou)
                ////////////////////次の問題があるのか判定
//                quizCount = quizCount + 1
//                quizArray = csvArray[quizCount].components(separatedBy:",")
//                //owari = 1
////                if Int(quizArray[7]) != selectLevel {
////                    owari = 1
////                    quizCount = quizCount - 1
////                } else {
////                    quizCount = quizCount - 1
////                }
                
//                print("足す前\(quizCount)")
//                quizCount = quizCount + 1
//                print(quizCount)
//                quizCount = quizCount - 1
                //////////////////////

            } else {
                print("あああああ")
                //owari = 1
                nextQuiz()
                //performSegue(withIdentifier: "toResultVC", sender: nil)
            }

            answerButton1.setTitle(quizArray[1], for: .normal)
            answerButton2.setTitle(quizArray[2], for: .normal)
            answerButton3.setTitle(quizArray[3], for: .normal)
            answerButton4.setTitle(quizArray[4], for: .normal)
            answerButton5.setTitle(quizArray[5], for: .normal)
        } else {
            print("うううう")
            //performSegue(withIdentifier: "toScoreVC", sender: nil)
            performSegue(withIdentifier: "toResultVC", sender: nil)
        }
        
    }
    }
    
    //CSV読み込むブロック
    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType:"csv")!
        do {
            let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
            let lineCange = csvData.replacingOccurrences(of: "\r",with:"\n")
            csvArray = lineCange.components(separatedBy:"\n")
            csvArray.removeLast()
        } catch {
            print("CSV読み込みエラー")
        }
        return csvArray
    }
}
