//
//  HistoryViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2023/04/02.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    
    
    @IBOutlet private weak var tableView: UITableView!
    
    var quizResults: [QuizResult] = []
    var questions: [Question] = []
    var cellArray:[String] = []
    var mondaiIDArray:[String] = []
    var questionCount: [Int: (correct: Int, incorrect: Int)] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("quizResults\(quizResults)")
        
        // questionCountを初期化
                for question in questions {
                    let mondaiID = question.quizNumber
                    let correctCountKey = "correctCount\(mondaiID)"
                    let incorrectCountKey = "incorrectCount\(mondaiID)"
                    if let correctCount = UserDefaults.standard.object(forKey: correctCountKey) as? Int,
                       let incorrectCount = UserDefaults.standard.object(forKey: incorrectCountKey) as? Int {
                        questionCount[mondaiID] = (correct: correctCount, incorrect: incorrectCount)
                    }
                }

        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cellArray = []
        mondaiIDArray = []
        
        
        
        //csv読み込むブロック
        questions = loadCSV(fileName: "quiz0")
        

        for question in questions {
                let mondaiID = question.quizNumber
                let correctCountKey = "correctCount\(mondaiID)"
                let incorrectCountKey = "incorrectCount\(mondaiID)"
                if let correctCount = UserDefaults.standard.object(forKey: correctCountKey) as? Int,
                   let incorrectCount = UserDefaults.standard.object(forKey: incorrectCountKey) as? Int {
                    questionCount[mondaiID] = (correct: correctCount, incorrect: incorrectCount)
                }
            }

        
        loadHistory()
       
        print("quizResults: \(quizResults)")
        tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quizResults.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        
        let quizResult = quizResults[indexPath.row]
        let mondaiID = quizResult.quizNumber
        
        if let count = questionCount[mondaiID] {
                cell.textLabel?.text = "\(quizResult.quizText) (正解: \(count.correct), 不正解: \(count.incorrect))"
            } else {
                cell.textLabel?.text = quizResult.quizText
            }
            
            cell.detailTextLabel?.text = quizResult.correct ? "正解" : "不正解"
            
            return cell
        

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
    
    func loadHistory() {
        quizResults = []

        
        var historyEntries: [(mondaiID: Int, historyEntry: Bool, timestamp: Date)] = []

        
        for question in questions {
            let mondaiID = question.quizNumber
            let historyKey = "history\(mondaiID)"
            let timestampKey = "timestamp\(mondaiID)"
            if let historyEntry = UserDefaults.standard.object(forKey: historyKey) as? Bool {
                    let timestamp = UserDefaults.standard.object(forKey: timestampKey) as? Date
                    
                    historyEntries.append((mondaiID: mondaiID, historyEntry: historyEntry, timestamp: timestamp ?? Date()))
                }

        }
        
        historyEntries.sort(by: { $0.timestamp > $1.timestamp })
        
        for entry in historyEntries {
            if let question = questions.first(where: { $0.quizNumber == entry.mondaiID }) {
                let quizResult = QuizResult(quizNumber: question.quizNumber, quizText: question.text, correct: entry.historyEntry, timestamp: entry.timestamp)
                quizResults.append(quizResult)
                
               
            }
        }
    }

}
