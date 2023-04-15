//
//  ResultViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/08/11.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet private var hanteiLabel: UILabel!
    @IBOutlet private var mondaiLabel: UILabel!
    @IBOutlet private var kaitouLabel: UILabel!
    @IBOutlet private var nextQuiz: UIButton!
    @IBOutlet private var okiniiri: UIButton!
    
    
    var correct = 0 // エラー対策
    var result = false// 正誤判定、１が正解
    var kotae = 0 // 問題の答え
    var mondai = "0"
    var correctCount = 1
    var mondaisuu = 0
    var selectedQuizTangen = ""
    var changeImage = 0
   // var mondaiIDstr = String(mondaiID)
    //var quizNumber: Int?
   // var okiniiri1 = ""//お気に入り登録
    var lastQuiz = false
    let touroku = 0
    
//    let questions = loadCSV(fileName: "quiz0")
//    let quizNumber = questions[quizCount].quizNumber
//    var maxQuizCount = 0
   // var fromBookmarkowari1 = 0
    
    
    
    
    @IBAction private func nextbutton(_ sender: Any) {
        
//        if fromBookmarkowari1 == 1 {
//
//            self.performSegue(withIdentifier: "toBookmarkVC", sender: nil)
//
//        } else
        if lastQuiz {
            print("resurtlastQuiz")
            self.performSegue(withIdentifier: "toScoreVC", sender: nil)

        } else {

            self.performSegue(withIdentifier: "toQuizVC1", sender: nil)
        }
    }
    
    

    // ナビゲーションバーの右ボタン
    @objc private func rightButtonPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "toScoreVC", sender: nil)
    }
    
    @IBAction private func okiniiri(_ sender: Any) {
        let touroku = UserDefaults.standard.integer(forKey: "\(mondaiID)")
        //print("quizNumberresu\(quizNumber)")
        if touroku == 0 {
            //print("mondaiID\(mondaiID)")
            //print("mondaiIDstr\(mondaiIDstr)")
            //print("quizNumber1\(quizNumber)")
            // okiniiri1 = "1"
            let touroku = 1
            UserDefaults.standard.set(touroku, forKey: "\(mondaiID)")
            let image = UIImage(systemName: "star.fill")
            let state = UIControl.State.normal
            okiniiri.setImage(image, for: state)
            print("登録\(touroku as Any)")
        } else {
            // okiniiri1 = "0"
            let touroku = 0
            UserDefaults.standard.set(touroku, forKey: "\(mondaiID)")
            let image = UIImage(systemName: "star")
            let state = UIControl.State.normal
            okiniiri.setImage(image, for: state)
            print("解除\(touroku as Any)")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testaa = UserDefaults.standard.bool(forKey: "\(mondaiID)")
       // print("testaa\(testaa)")
        //print("quizResult1\(quizResults)")
       // print("mondaiID\(mondaiID)")
        let questions = loadCSV(fileName: "quiz0")
        let quizNumber = questions[quizCount].quizNumber
        let quizText = questions[quizCount].text
        //print("quizResult1\(quizResults)")
        
        //print("quizText\(quizText)")
        //print("quizNumberresr\(quizNumber)")


        if lastQuiz == true {
            nextQuiz.setTitle("終了", for: .normal)
//            selectQuizTangenCount = 0
//            maxSelectTangenQuizCount = 0
//            quizCount = 0
        }

        let touroku = UserDefaults.standard.integer(forKey: "\(mondaiID)")
        //print("touroku\(touroku)")
        
        
    // お気に入りボタン
        if touroku == 0 {
            let image = UIImage(systemName: "star")// お気に入り画像
            let state = UIControl.State.normal// お気に入り画像
            okiniiri.setImage(image, for: state)
        } else {
            let image = UIImage(systemName: "star.fill")
            let state = UIControl.State.normal
            okiniiri.setImage(image, for: state)
        }

        // ナビゲーションバーの右ボタン
        let action = #selector(rightButtonPressed(_:))
//        if fromBookmarkowari1 == 1 {
//            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "",style: .plain,target: self,action: action)
//            self.navigationItem.setHidesBackButton(true, animated: true)//戻るボタンを消
//            
//        } else {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "終了する",style: .plain,target: self,action: action)
       self.navigationItem.setHidesBackButton(true, animated: true)// 戻るボタンを消
//        }
        
        hanteiLabel.text = result ? "正解" : "不正解"
        
        kaitouLabel.text = "正解は\(kotae)番！ "
        
        mondaiLabel.text = mondai

    }
    // 遷移先の分岐
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "toScoreVC" {
                let scoreVC = segue.destination as! ScoreViewController
                scoreVC.correctCount2 = correctCount
            } else if segue.identifier == "toQuizVC1"{
                let quizVC = segue.destination as! QuizViewController
                selectQuizTangenCount += 1
                quizCount += 1
                //quizVC.currentQuestion?.quizNumber = quizNumber
               // print("quizCountResult\(quizCount)")
                quizVC.selectedQuizTangen = selectedQuizTangen
                quizVC.correctCount = correctCount
            }
        }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        // navigationController?.isNavigationBarHidden = false
    }
    
    func loadCSV(fileName: String) -> [Question] {
        var questions: [Question] = []
        if let csvBundle = Bundle.main.path(forResource: fileName, ofType:"csv") {
            do {
                let csvData = try String(contentsOfFile: csvBundle, encoding: .utf8)
                let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
                let csvRows = lineChange.components(separatedBy: "\n")
                for csvRow in csvRows {
                    let csvColumns = csvRow.components(separatedBy: ",")
                    if csvColumns.count >= 4 {
                        let text = csvColumns[0]
                        let choices = [csvColumns[1], csvColumns[2], csvColumns[3], csvColumns[4], csvColumns[5]]
                        let answer = Int(csvColumns[6]) ?? 0
                        
                        let category = csvColumns[7]
                        let imageName = csvColumns[8]
                        let wakaran = Int(csvColumns[9]) ?? 0
                        let quizNumber = Int(csvColumns[10]) ?? 0
                        let question = Question(text: text, choices: choices, answer: answer, category: category, imageName: imageName, wakaran: wakaran, quizNumber: quizNumber)
                        questions.append(question)
                    }
                }
            } catch {
                print("CSV読み込みエラー")
            }
        }
        return questions
    }


}
