//
//  BookmackViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/08/28.
//

import UIKit

class BookmarkViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarDelegate,UITabBarControllerDelegate{
    
    var questions: [Question] = []
    var quizCount = 0
    var mondaiID = ""
    var cellArray:[String] = []
    var mondaiIDArray:[String] = []// 問題ID格納してquizviewへ受け渡す
    
    @IBOutlet private var bookmark: UITabBar!// UITabBarItemから変更
    
    @IBOutlet private weak var okiniirilist: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        okiniirilist.delegate = self
        okiniirilist.dataSource = self
    }

    // 画面が遷移する直前に実行
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        cellArray = []
        quizCount = 0
        mondaiIDArray = []

        // csv読み込むブロック
        questions = loadCSV(fileName: "quiz0")

        nextQuiz()
        okiniirilist.reloadData()
    }// ViewWillAppear終了
    
    // 次の問題を表示させるブロック
    func nextQuiz() {
        while quizCount < questions.count {
            let currentQuestion = questions[quizCount]
            mondaiID = String(currentQuestion.quizNumber)
            let touroku = UserDefaults.standard.string(forKey: "\(mondaiID)")
            if touroku == "1" {
                cellArray.append(currentQuestion.text)
                mondaiIDArray.append(mondaiID)
            }
                quizCount += 1
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
    
    // テーブルの行数を指定するメソッド（必須）
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        cellArray.count
    }
    
    // セルの中身を設定するメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath)
        cell.textLabel?.text = cellArray[indexPath.row]
        return cell
    }
    
    // セルがタップされた時の処理
    func tableView(_ okiniirilist: UITableView,didSelectRowAt indexPath: IndexPath){
        mondaiID = mondaiIDArray[indexPath.row]
        //print(mondaiID)
        performSegue(withIdentifier: "toQuizVC", sender: nil)
    }
    // エラー対策
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuizVC" {
                if let indexPath = okiniirilist.indexPathForSelectedRow {
                    let toQuizVC = segue.destination as! QuizViewController
                    toQuizVC.fromBookmark = 1
                    toQuizVC.selectedMondaiID = Int(mondaiIDArray[indexPath.row])
                }
            }
//        let toQuizVC = segue.destination as! QuizViewController
//        toQuizVC.fromBookmark = 1
    }
}
