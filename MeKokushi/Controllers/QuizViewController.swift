//
//  QuizViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/07/30.
//

import UIKit

var selectQuizTangenCount = 0
var maxSelectTangenQuizCount = 0
var mondaiID = 0
struct Question {
    var text: String
    var choices: [String]
    var answer: Int
    var category: String
    var imageName: String
    var wakaran: Int
    var quizNumber: Int
}

struct QuizResult {
    var quizNumber: Int
    var quizText: String
    var correct: Bool
   var timestamp: Date
}

let question = Question(text: "Question text", choices: ["Choice 1", "Choice 2", "Choice 3", "Choice 4", "Choice 5"], answer: 10, category: "Category", imageName: "Image name", wakaran: 0, quizNumber: 1)
var questions: [Question] = []
var text: String!
var choices: [String]!
var answer: Int!
var category: String!
var imageName: String!
var wakaran: Int!
var quizNumber: Int!
var quizText: String!
var quizCount = 0
var quizResults: [QuizResult] = []


class QuizViewController: UIViewController {
    
    @IBOutlet private var quizNumberLabel: UILabel!
    @IBOutlet private var quizTextView: UITextView!
    @IBOutlet private var answerButton1: UIButton!
    @IBOutlet private var answerButton2: UIButton!
    @IBOutlet private var answerButton3: UIButton!
    @IBOutlet private var answerButton4: UIButton!
    @IBOutlet private var answerButton5: UIButton!
    @IBOutlet private var judgeImageView: UIImageView!
    @IBOutlet private var quizImageView: UIImageView!
    
    var csvArray: [String] = []// CSVを入れる箱
    var quizArray: [String] = []
    var correctCount = 0// 正解カウント
    var selectedQuizTangen = ""// SelectTangenViewからの値が入る
    var quizImage = ""
    var result = false
    var lastsQuiz = false// 次の問題があるのか判定
    var mondai = ""// リザルトに表示させる問題文、mondaiに代入
    
    var fromBookmark = 0
    var fromBookmarkowari = 0
    var currentQuestion: Question?
    var selectedMondaiID: Int?
   // var isCorrect = false
    
    // ナビゲーションバーの右ボタン
    @objc func rightButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print("quizResult2\(quizResults)")
        // ナビゲーションバーの右ボタン
        let action = #selector(rightButtonPressed(_:))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "終了する",style: .plain,target: self,action: action)
        self.navigationItem.setHidesBackButton(true, animated: true)// 戻るボタンを消す
        
        // csv読み込むブロック
        let questions = loadCSV(fileName: "quiz0")
        let category = questions[quizCount].category
        quizText = questions[quizCount].text
        let imageName = questions[quizCount].imageName
        let selectQuestion = questions[quizCount]
        let quizNumber = questions[quizCount].quizNumber
        
        currentQuestion = questions[quizCount]
        
        if fromBookmark == 1 {
            if let selectedMondaiID = selectedMondaiID {
                // ここで問題データをロードします。
                let questions = loadCSV(fileName: "quiz0")
                
                // 問題を検索し、表示します。
                for question in questions {
                    if question.quizNumber == selectedMondaiID {
                        // ここで、見つかった問題を表示するために、
                        // 適切なUIコンポーネントに値を設定します。
                        quizNumberLabel.text = "第\(selectQuizTangenCount)問"
                        quizTextView.text = question.text.replacingOccurrences(of: "　", with: "\n")
                        mondai = question.text
                        mondaiID = question.quizNumber
                        quizImage = question.imageName
                        quizImageView.image = UIImage(named: quizImage)
                        answerButton1.setTitle(question.choices[0], for: .normal)
                        answerButton2.setTitle(question.choices[1], for: .normal)
                        answerButton3.setTitle(question.choices[2], for: .normal)
                        answerButton4.setTitle(question.choices[3], for: .normal)
                        answerButton5.setTitle(question.choices[4], for: .normal)
                        break
                    }
                }
            }
        } else {
  
            
            getMaxSelectTangenQuizCount()
            
            if category == selectedQuizTangen {
                if selectQuizTangenCount == 0 {
                    selectQuizTangenCount += 1
                }
                lastsQuiz = maxSelectTangenQuizCount == selectQuizTangenCount
                quizNumberLabel.text = "第\(selectQuizTangenCount)問"
                quizTextView.text = quizText.replacingOccurrences(of: "　", with: "\n")
                mondaiID = quizNumber
                quizImage = imageName
                quizImageView.image = UIImage(named: quizImage)
                answerButton1.setTitle(selectQuestion.choices[0], for: .normal)
                answerButton2.setTitle(selectQuestion.choices[1], for: .normal)
                answerButton3.setTitle(selectQuestion.choices[2], for: .normal)
                answerButton4.setTitle(selectQuestion.choices[3], for: .normal)
                answerButton5.setTitle(selectQuestion.choices[4], for: .normal)
               //print("quizText\(quizText)")
                //print("quizNumber\(quizNumber)")
                
            } else {
                nextQuiz()
            }
            
            buttonLayout()
        }
            func nextQuiz() {
                quizCount += 1
                
                while quizCount < questions.count {
                    let nextQuestion = questions[quizCount]
                    
                    if nextQuestion.category == selectedQuizTangen {
                        lastsQuiz = maxSelectTangenQuizCount == selectQuizTangenCount
                        if selectQuizTangenCount == 0 {
                            selectQuizTangenCount += 1
                        }
                        quizNumberLabel.text = "第\(selectQuizTangenCount)問"
                        quizTextView.text = nextQuestion.text.replacingOccurrences(of: "　", with: "\n")
                        mondai = nextQuestion.text
                        mondaiID = nextQuestion.quizNumber
                        quizImage = nextQuestion.imageName
                        quizImageView.image = UIImage(named: quizImage)
                        answerButton1.setTitle(nextQuestion.choices[0], for: .normal)
                        answerButton2.setTitle(nextQuestion.choices[1], for: .normal)
                        answerButton3.setTitle(nextQuestion.choices[2], for: .normal)
                        answerButton4.setTitle(nextQuestion.choices[3], for: .normal)
                        answerButton5.setTitle(nextQuestion.choices[4], for: .normal)
                        break
                    } else {
                        quizCount += 1
                    }
                }
            }
            
            func buttonLayout() {
                
                answerButton1.setTitleColor(UIColor.black,for: .normal)
                answerButton2.setTitleColor(UIColor.black,for: .normal)
                answerButton3.setTitleColor(UIColor.black,for: .normal)
                answerButton4.setTitleColor(UIColor.black,for: .normal)
                answerButton5.setTitleColor(UIColor.black,for: .normal)
                
                answerButton1.layer.borderWidth = 2
                answerButton2.layer.borderWidth = 2
                answerButton3.layer.borderWidth = 2
                answerButton4.layer.borderWidth = 2
                answerButton5.layer.borderWidth = 2
                
                answerButton1.layer.borderColor = UIColor(red: 252 / 255, green: 204 / 255, blue: 143 / 255, alpha: 1.0).cgColor
                answerButton2.layer.borderColor = UIColor(red: 252 / 255, green: 204 / 255, blue: 143 / 255, alpha: 1.0).cgColor
                answerButton3.layer.borderColor = UIColor(red: 252 / 255, green: 204 / 255, blue: 143 / 255, alpha: 1.0).cgColor
                answerButton4.layer.borderColor = UIColor(red: 252 / 255, green: 204 / 255, blue: 143 / 255, alpha: 1.0).cgColor
                answerButton5.layer.borderColor = UIColor(red: 252 / 255, green: 204 / 255, blue: 143 / 255, alpha: 1.0).cgColor
                
                answerButton1.titleLabel?.adjustsFontSizeToFitWidth = true
                answerButton2.titleLabel?.adjustsFontSizeToFitWidth = true
                answerButton3.titleLabel?.adjustsFontSizeToFitWidth = true
                answerButton4.titleLabel?.adjustsFontSizeToFitWidth = true
                answerButton5.titleLabel?.adjustsFontSizeToFitWidth = true
                
                answerButton1.titleLabel?.numberOfLines = 2
                answerButton2.titleLabel?.numberOfLines = 2
                answerButton3.titleLabel?.numberOfLines = 2
                answerButton4.titleLabel?.numberOfLines = 2
                answerButton5.titleLabel?.numberOfLines = 2
            }
        }// ここまでがviewDidLoad内
        
        func getMaxSelectTangenQuizCount() {
            if maxSelectTangenQuizCount == 0 {
                let questions = loadCSV(fileName: "quiz0") // ファイル名を修正
                maxSelectTangenQuizCount = questions.filter { $0.category == selectedQuizTangen }.count
                //print("maxSelectTangenQuizCount\(maxSelectTangenQuizCount)")
            }
        }
    // Score画面の変数correctに代入される
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let historyVC = segue.destination as? HistoryViewController, segue.identifier == "toHistoryVC" {
            historyVC.quizResults = quizResults
        } else {
            guard let currentAnswer = currentQuestion?.answer else { return }
            let resultVC = segue.destination as! ResultViewController// エラー対策
            resultVC.result = result
            resultVC.kotae = currentAnswer
            resultVC.mondai = mondai
            resultVC.correctCount = correctCount
            resultVC.selectedQuizTangen = selectedQuizTangen
            resultVC.lastQuiz = lastsQuiz// 次の問題があるのか判定
        }
    }

    
    @IBAction private func btmAction(_ sender: UIButton) {
        let correctCountKey = "correctCount\(mondaiID)"
        let incorrectCountKey = "incorrectCount\(mondaiID)"
        
 
        let historyKey = "history\(mondaiID)"
        let timestampKey = "timestamp\(mondaiID)"
            guard let currentAnswer = currentQuestion?.answer else { return }
        if sender.tag == currentAnswer {
            correctCount += 1
            result = true
            UserDefaults.standard.set(true, forKey: historyKey)
            judgeImageView.image = UIImage(named: "correct")
            print("mondaiID\(mondaiID)")
            print("正解！")
            let currentCorrectCount = UserDefaults.standard.integer(forKey: correctCountKey)
            UserDefaults.standard.set(currentCorrectCount + 1, forKey: correctCountKey)
        } else {
            result = false
            UserDefaults.standard.set(false, forKey: historyKey)
            judgeImageView.image = UIImage(named: "incorrect")
            print("mondaiID\(mondaiID)")
            print("不正解！ ")
            let currentIncorrectCount = UserDefaults.standard.integer(forKey: incorrectCountKey)
            UserDefaults.standard.set(currentIncorrectCount + 1, forKey: incorrectCountKey)
        }



        UserDefaults.standard.set(Date(), forKey: timestampKey)

            judgeImageView.isHidden = false// ２回目に表示させる
            answerButton1.isEnabled = false
            answerButton2.isEnabled = false
            answerButton3.isEnabled = false
            answerButton4.isEnabled = false
            answerButton5.isEnabled = false
            // 0.5秒後に非表示
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.judgeImageView.isHidden = true
                self.answerButton1.isEnabled = true
                self.answerButton2.isEnabled = true
                self.answerButton3.isEnabled = true
                self.answerButton4.isEnabled = true
                self.answerButton5.isEnabled = true
                self.performSegue(withIdentifier: "toResultVC", sender: nil)// リザルト画面へ
            }
        }
        
        // CSV読み込むブロック
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
    

