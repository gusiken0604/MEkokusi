//
//  QuizViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/07/30.
//

import UIKit

class QuizViewController: UIViewController {

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
    var quizTangen = ""//SelectTangenViewからの値が入る
    var quizImage = ""
    var result = false
    var quizNumber = 1
    var lastQuiz = false//次の問題があるのか判定
    var mondai = ""//リザルトに表示させる問題文、mondaiに代入
   // var resultMondaiID = ""
    var fromBookmark = 0
    var fromBookmarkowari = 0
    
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
        
        
        //csv読み込むブロック
        csvArray = loadCSV(fileName: "quiz0")//quiz0.csv固定
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        print("次の問題\(lastQuiz)")
        //終わり判定
        if quizCount + 1  < csvArray.count {
            
            //print("次の問題1\(csvArray.count)")
        } else {
            lastQuiz = true
        }
        
        //print("変数クイズ単元は\(quizTangen)")

        //問題テキスト
        if quizArray[7] == quizTangen {
            quizNumberLabel.text = "第\(quizNumber)問"
            mondai = quizArray[0]
            print("resultMondai\(mondai)")
            quizTextView.text = quizArray[0].replacingOccurrences(of: "　", with: "\n")
            quizImage = quizArray[8]
            quizImageView.image = UIImage(named: quizImage)


        } else {
            nextQuiz()
        }

        buttonLayout()
    }
    
    //Score画面の変数correctに代入される
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as! ResultViewController//エラー対策
        resultVC.result = result
        resultVC.kotae = quizArray[6]
        resultVC.mondai = mondai
        resultVC.correctCount = correctCount
        resultVC.quizCount = quizCount
        resultVC.mondaisuu = quizNumber
        resultVC.quizTangen = quizTangen
        resultVC.mondaiID = quizArray[10]
        //print("登録判定\(quizArray[10])")
        resultVC.lastQuiz = lastQuiz//次の問題があるのか判定
        resultVC.fromBookmarkowari1 = fromBookmarkowari
    }
    //ボタンを押したときに呼ばれる
    @IBAction func btnAction(sender:UIButton){
        
        if lastQuiz == false {
            quizCount = quizCount + 1
            print("登録判定3\(quizArray[10])")
            quizArray = csvArray[quizCount].components(separatedBy:",")
            quizCount = quizCount - 1
            print("登録判定4\(quizArray[10])")
            if sender.tag == Int(quizArray[6]){
                correctCount += 1
                print("スコア:\(correctCount)")
                result = true
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
            
        } else {
            if sender.tag == Int(quizArray[6]) {
                correctCount += 1
                print("スコア:\(correctCount)")
                result = true
                print("正解")
                judgeImageView.image = UIImage(named: "correct")
            } else {
                
                print("不正解")
                judgeImageView.image = UIImage(named: "incorrect")
            }

            judgeImageView.isHidden = false//２回目に表示させる
            answerButton1.isEnabled = false
            answerButton2.isEnabled = false
            answerButton3.isEnabled = false
            answerButton4.isEnabled = false
            answerButton5.isEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ //0.5秒後に非表示
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
        
        quizCount += 1
        print("nextQuiz()quizCount\(quizCount)")
        if quizCount < csvArray.count {
            quizArray = csvArray[quizCount].components(separatedBy:",")
            
            if quizArray[7] == quizTangen {
                quizNumberLabel.text = "第\(quizNumber)問"
                quizTextView.text = quizArray[0].replacingOccurrences(of: "　", with: "\n")
                mondai = quizArray[0]
                quizImage = quizArray[8]
                quizImageView.image = UIImage(named: quizImage)
                
            } else {
                nextQuiz()
            }
            
            answerButton1.setTitle(quizArray[1], for: .normal)
            answerButton2.setTitle(quizArray[2], for: .normal)
            answerButton3.setTitle(quizArray[3], for: .normal)
            answerButton4.setTitle(quizArray[4], for: .normal)
            answerButton5.setTitle(quizArray[5], for: .normal)
            
        } else {
           // print("nextQuiz()else2")
            
            performSegue(withIdentifier: "toResultVC", sender: nil)
        }
    }
    
    func buttonLayout() {
        
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
