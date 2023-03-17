//
//  QuizViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/07/30.
//

import UIKit

var maxSelectTangenQuizCount = 0
//struct Question {
//    var text: String
//    var choices: [String]
//    var answer: Int
//    var category: String
//    var imageName: String
//    var wakaran: Int
//    var quizNumber: Int
//}
//

//
//var questions: [Question] = []
//private let question = Question(text: "Question text", choices: ["Choice 1", "Choice 2", "Choice 3", "Choice 4", "Choice 5"], answer: 5, category: "Category", imageName: "Image name", wakaran: 0, quizNumber: 1)
//
//private let text = question.text
//private let choices = question.choices
//private let firstChoice = question.choices[0]
//private let secondChoice = question.choices[1]
//private let thirdChoice = question.choices[2]
//private let fourthChoice = question.choices[3]
//private let fifthChoice = question.choices[4]
//private let answer = question.answer
//private let category = question.category
//private let imageName = question.imageName
//private let wakaran = question.wakaran
//private let quizNumber = question.quizNumber

class QuizViewController: UIViewController {
    
    struct Question {
        var text: String
        var choices: [String]
        var answer: Int
        var category: String
        var imageName: String
        var wakaran: Int
        var quizNumber: Int
    }

    var maxSelectTangenQuizCount = 0

    var questions: [Question] = []
    var question: Question!
    var text: String!
    var choices: [String]!
    var firstChoice: String!
    var secondChoice: String!
    var thirdChoice: String!
    var fourthChoice: String!
    var fifthChoice: String!
    var answer: Int!
    var category: String!
    var imageName: String!
    var wakaran: Int!
    var quizNumber: Int!

    
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
    var quizCount = 0
    var correctCount = 0// 正解カウント
    var selectedQuizTangen = ""// SelectTangenViewからの値が入る
    var quizImage = ""
    var result = false
    //var quizNumber = 1
    var lastsQuiz = false// 次の問題があるのか判定
    var mondai = ""// リザルトに表示させる問題文、mondaiに代入
    var fromBookmark = 0
    var fromBookmarkowari = 0
   // var questions: [Question] = []

    // ナビゲーションバーの右ボタン
    @objc func rightButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ナビゲーションバーの右ボタン
        let action = #selector(rightButtonPressed(_:))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "終了する",style: .plain,target: self,action: action)
        self.navigationItem.setHidesBackButton(true, animated: true)// 戻るボタンを消す
        
        // csv読み込むブロック
//        csvArray = loadCSV(fileName: "quiz0")// quiz0.csv固定
//        quizArray = csvArray[quizCount].components(separatedBy: ",")
        
        question = Question(text: "Question text", choices: ["Choice 1", "Choice 2", "Choice 3", "Choice 4", "Choice 5"], answer: 5, category: "Category", imageName: "Image name", wakaran: 0, quizNumber: 1)

        text = question.text
        choices = question.choices
        firstChoice = question.choices[0]
        secondChoice = question.choices[1]
        thirdChoice = question.choices[2]
        fourthChoice = question.choices[3]
        fifthChoice = question.choices[4]
        answer = question.answer
        category = question.category
        imageName = question.imageName
        wakaran = question.wakaran
        quizNumber = question.quizNumber
        
//        let quesstions = loadCSV(fileName: "quiz0")// quiz0.csv固定
//    let quizArray = questions[quizCount]//.components(separatedBy: ",")
        let questions = loadCSV(fileName: "quiz0")
        
        var category = questions[quizCount].category
        var quizText = questions[quizCount].text// 最初の構造体のcategoryを取得する例
        var imageName = questions[quizCount].imageName
        var firstChoice = questions[quizCount].choices[0]
        var secondChoice = questions[quizCount].choices[1]
        var thirdChoice = questions[quizCount].choices[2]
        var fourthChoice = questions[quizCount].choices[3]
        var fifthChoice = questions[quizCount].choices[4]
        var answer = questions[quizCount].answer
        
//        test()

        func test() {
            print("関数内で構造体を使いたい")
            print("\(quizText)")
            print("\(category)")
            print("\(imageName)")
            print("aaa\(firstChoice)")
            print("\(answer)")

        }

        
        print("maxSelectTangenQuizCount\(maxSelectTangenQuizCount)")
        if maxSelectTangenQuizCount == 0 {
            print("マックスクイズ数aa\(maxSelectTangenQuizCount)")
            getMaxSelectTangenQuizCount()
        }
        
        if quizNumber == maxSelectTangenQuizCount {
            lastsQuiz = true
        }
        
        func getMaxSelectTangenQuizCount() {
            let questions = loadCSV(fileName: "quiz0.csv")
            
            for question in questions {
                
               // if question.category == selectedQuizTangen {
                if category == selectedQuizTangen {
                    maxSelectTangenQuizCount += 1
                print("マックスクイズ数a\(maxSelectTangenQuizCount)")
                }
            }
        }

//        func getMaxSelectTangenQuizCount() {
//            while quizCount < csvArray.count {
//                let quizArray = csvArray[quizCount].components(separatedBy: ",")
//
//                if quizArray[7] == selectedQuizTangen {
//                    maxSelectTangenQuizCount += 1
//                }
//                quizCount += 1
//            }
//            quizCount = 0
//            let quizArray = csvArray[quizCount].components(separatedBy: ",")
//        }
       // var category = quesstions.category
        
        
        //if quizArray[7] == selectedQuizTangen {
        if category == selectedQuizTangen {
            
            quizNumberLabel.text = "第\(quizNumber)問"
            //mondai = quizText
            print("quizText\(quizText)")
            // mondai = quizArray[0]
            quizTextView.text = quizText.replacingOccurrences(of: "　", with: "\n")
            //quizTextView.text = quizArray[0].replacingOccurrences(of: "　", with: "\n")
            //quizImage = quizArray[8]
            quizImage = imageName
            quizImageView.image = UIImage(named: quizImage)
            
        } else {
            nextQuiz()
        }
        print("表示できる？??\(firstChoice)")
        buttonLayout()
    }
    
    // Score画面の変数correctに代入される
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let resultVC = segue.destination as! ResultViewController// エラー対策
        resultVC.result = result
        //resultVC.kotae = answer
        //resultVC.kotae = quizArray[6]
        resultVC.mondai = mondai
        resultVC.correctCount = correctCount
        resultVC.quizCount = quizCount
        resultVC.mondaisuu = quizNumber
        resultVC.selectedQuizTangen = selectedQuizTangen
//        resultVC.mondaiID = quizArray[10]
        resultVC.lastQuiz = lastsQuiz// 次の問題があるのか判定

        // resultVC.fromBookmarkowari1 = fromBookmarkowari
    }
    // ボタンを押したときに呼ばれる
    @IBAction private func btnAction(sender:UIButton){
        
            //if sender.tag == Int(quizArray[6]){
        if sender.tag == answer {
                correctCount += 1

                result = true

                judgeImageView.image = UIImage(named: "correct")
            } else {
                print("不正解")
                judgeImageView.image = UIImage(named: "incorrect")
            }

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
    // 次の問題を表示させるブロック
    func nextQuiz(){
        
        if quizCount + 1 < csvArray.count {
            quizCount += 1
            quizArray = csvArray[quizCount].components(separatedBy:",")
            if quizArray[7] == selectedQuizTangen {
                 quizNumberLabel.text = "第\(quizNumber)問"
                quizTextView.text = quizArray[0].replacingOccurrences(of: "　", with: "\n")
                mondai = quizArray[0]
                quizImage = quizArray[8]
                quizImageView.image = UIImage(named: quizImage)
                
              } else {
                  print("表示できる?？\(firstChoice)")
                nextQuiz()
                  
            }
//            let question = Question(text: "Question text", choices: ["Choice 1", "Choice 2", "Choice 3", "Choice 4", "Choice 5"], answer: 2, category: "Category", imageName: "Image name", wakaran: 0, quizNumber: 1)
//            let firstChoice = question.choices[0]
//            let secondChoice = question.choices[1]
//            let thirdChoice = question.choices[2]
//            let fourthChoice = question.choices[3]
//            let fifthChoice = question.choices[4]
            print("表示できる????\(firstChoice)")
            answerButton1.setTitle(firstChoice, for: .normal)
            answerButton2.setTitle(secondChoice, for: .normal)
            answerButton3.setTitle(thirdChoice, for: .normal)
            answerButton4.setTitle(fourthChoice, for: .normal)
            answerButton5.setTitle(fifthChoice, for: .normal)
            
//            answerButton1.setTitle(quizArray[1], for: .normal)
//            answerButton2.setTitle(quizArray[2], for: .normal)
//            answerButton3.setTitle(quizArray[3], for: .normal)
//            answerButton4.setTitle(quizArray[4], for: .normal)
//            answerButton5.setTitle(quizArray[5], for: .normal)
            
      }
        
    }
    
    func buttonLayout() {
        //var questions: [Question] = []
        //let question = Question(text: "Question text", choices: ["Choice 1", "Choice 2", "Choice 3", "Choice 4", "Choice 5"], answer: 5, category: "Category", imageName: "Image name", wakaran: 0, quizNumber: 1)
//        var firstChoice = questions[quizCount].choices[0]
       // let firstChoice = questions[quizCount].choices[0]
        print("\(text)")
        print("\(category)")
        print("\(imageName)")
        print("aaa\(firstChoice)")
        print("\(answer)")
        
        print("表示できる？\(firstChoice)")
        print("表示できる？\(question.choices[0])")
        answerButton1.setTitle(question.choices[0], for: .normal)
        answerButton2.setTitle(secondChoice, for: .normal)
        answerButton3.setTitle(thirdChoice, for: .normal)
        answerButton4.setTitle(fourthChoice, for: .normal)
        answerButton5.setTitle(fifthChoice, for: .normal)
        
//        answerButton1.setTitle(quizArray[1],for: .normal)
//        answerButton2.setTitle(quizArray[2],for: .normal)
//        answerButton3.setTitle(quizArray[3],for: .normal)
//        answerButton4.setTitle(quizArray[4],for: .normal)
//        answerButton5.setTitle(quizArray[5],for: .normal)
        // ボタン文字色
        answerButton1.setTitleColor(UIColor.black,for: .normal)
        answerButton2.setTitleColor(UIColor.black,for: .normal)
        answerButton3.setTitleColor(UIColor.black,for: .normal)
        answerButton4.setTitleColor(UIColor.black,for: .normal)
        answerButton5.setTitleColor(UIColor.black,for: .normal)
        // ボタン枠
        answerButton1.layer.borderWidth = 2
        answerButton2.layer.borderWidth = 2
        answerButton3.layer.borderWidth = 2
        answerButton4.layer.borderWidth = 2
        answerButton5.layer.borderWidth = 2
        // ボタン枠色
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
    
    // CSV読み込むブロック
//    func loadCSV(fileName: String) -> [String] {
//        let csvBundle = Bundle.main.path(forResource: fileName, ofType:"csv") ?? ""
//        do {
//            let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
//            let lineCange = csvData.replacingOccurrences(of: "\r",with:"\n")
//            csvArray = lineCange.components(separatedBy:"\n")
//            csvArray.removeLast()
//        } catch {
//            print("CSV読み込みエラー")
//        }
//        return csvArray
//    }
    
//    struct Question {
//        var text: String
//        var choices: [String]
//        var answer: Int
//        var category: String
//        var imageName: String
//        var wakaran: Int
//        var quizNumber: Int
//    }
    
//    csvArray = loadCSV(fileName: "quiz0")// quiz0.csv固定
//quizArray = csvArray[quizCount].components(separatedBy: ",")
    
//        quesstions = loadCSV(fileName: "quiz0")// quiz0.csv固定
//    quizArray = questions[quizCount].components(separatedBy: ",")
    
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
    
//    struct MyData {
//        let column0: String
//        let column1: String
//        let column2: String
//        let column3: String
//        let column4: String
//        let column5: String
//        let column6: Int
//        let column7: String
//        let column8: String
//        let column9: Int
//        let column10: Int
//    }
//
//    func loadCSV(fileName: String) -> [CSVLine] {
//        var csvArray: [CSVLine] = []
//        if let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv") {
//            do {
//                let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
//                let lineCange = csvData.replacingOccurrences(of: "\r",with:"\n")
//                let csvLines = lineCange.components(separatedBy:"\n")
//                for csvLine in csvLines {
//                    let columns = csvLine.components(separatedBy:",")
//                    if columns.count == 10 { // カラム数によっては無視する場合がある
//                        let csvLine = CSVLine(column0: columns[0], column1: columns[1], column2: columns[2], column3: columns[3], column4: columns[4], column5: columns[5], column6: Int(columns[6]) ?? 0, column7: columns[7], column8: columns[8], column9: Int(columns[9]) ?? 0, column10: Int(columns[10]) ?? 0)
//                        csvArray.append(csvLine)
//                    }
//                }
//            } catch {
//                print("CSV読み込みエラー")
//            }
//        }
//        return csvArray
//    }


}
