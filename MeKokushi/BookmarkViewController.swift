//
//  BookmackViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/08/28.
//

import UIKit

class BookmarkViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var csvArray: [String] = []//CSVを入れる箱
    var quizArray: [String] = []
    var quizCount = 0
    //var CountryList = ["アメリカ","中国","日本","ドイツ","イギリス"]
    
    var mondaiID = "0"
    var touroku = "0"
    //var tablegyosu = 0
    var cellArray:[String] = []
    //var cellNum = 0 //セルの番号
    var mondaiIDArray:[String] = []//問題ID格納してquizviewへ受け渡す
    //var fromBookmark = 0
    
    @IBOutlet var bookmark: UITabBar!//UITabBarItemから変更
    
    @IBOutlet weak var okiniirilist: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bookmark.delegate = self
        //bookmark.dataSource = self
        okiniirilist.delegate = self
        okiniirilist.dataSource = self
        
//        print("お気に入りフラグ1\(touroku)")
//        //print("\(touroku1!)")
//        //csv読み込むブロック
//        csvArray = loadCSV(fileName: "quiz0")//quiz0.csv固定
//        quizArray = csvArray[quizCount].components(separatedBy: ",")
//        print("クイズカウント1番\(quizCount)")
//        mondaiID = quizArray[10]
//        let touroku = UserDefaults.standard.string(forKey: mondaiID)
//        print("お気に入りフラグ2\(touroku!)")
//        print(quizArray[10])
//        // print(csvArray)
//
//        if touroku == "1" {
//            cellArray += [quizArray[0]]
//            print("お気に入りフラグifff\(touroku!)")
//            print("クイズカウント2番\(quizCount)")//0
//            nextQuiz()
//        } else {
//            nextQuiz()//修正前
//        }

        //次の問題を表示させるブロックfor
//        for _ in 1...4 {//ここがわからん
//            quizCount += 1
//            quizArray = csvArray[quizCount].components(separatedBy:",")
//            print("クイズカウント4番\(quizCount)")
//            mondaiID = quizArray[10]
//            print(mondaiID)
//            let touroku = UserDefaults.standard.string(forKey: mondaiID)
//            //print(cellArray)
//            //print("お気に入りフラグ3\(touroku!)")
//            if touroku == "1" {
//                cellArray += [quizArray[0]]
//                print(cellArray)
//            } else {
//                //nextQuiz()
//            }
//            //print("クイズカウント4番\(quizCount)")
//        }

        //okiniirilist.reloadData()

        
    }// viewDidLoad終わり
    
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        switch item.tag{
//        case 1:tableView.reloadData()
//        default:print("どのボタンでもない")
//        }
//    }
//    @IBAction func bookmark(_ sender: Any) {
//        tableView.reloadData()
//    }
//    func okiniirilist(_ tableview: UITableView,didselectRowAt indexPath: IndexPath){
//        print("test")
//    }
//
    
    //画面が遷移する直前に実行
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //csvArray: [String] = []//CSVを入れる箱
        //quizArray: [String] = []
    //quizArray = []
        cellArray = []
        quizCount = 0
        mondaiIDArray = []
        //okiniirilist.refreshControl?.beginRefreshing()
        print("お気に入りフラグ1\(touroku)")
        //print("\(touroku1!)")
        //csv読み込むブロック
        csvArray = loadCSV(fileName: "quiz0")//quiz0.csv固定
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        print("クイズカウント1番\(quizCount)")
        mondaiID = quizArray[10]
        let touroku = UserDefaults.standard.string(forKey: mondaiID)
        print("お気に入りフラグ2\(touroku!)")
        print(quizArray[10])
        // print(csvArray)
        
        if touroku == "1" {
            cellArray += [quizArray[0]]
            mondaiIDArray += [quizArray[10]]
            print("お気に入りフラグifff\(touroku!)")
            print("クイズカウント2番\(quizCount)")//0
            nextQuiz()
        } else {
            nextQuiz()//修正前
        }
        okiniirilist.reloadData()
//       okiniirilist.refreshControl?.beginRefreshing()
        //quizArray = []
    //quizArray: [String] = []
        //print("aaaaaa\(quizArray)")
        //cellArray.removeAll()
        print("画面遷移")
        //print(quizArray)
    }
    //次の問題を表示させるブロック
    func nextQuiz(){
        //tablegyosu += 1
        //print("行数\(tablegyosu)")
        quizCount += 1
        //print("クイズカウント3番\(quizCount)")//1
        if quizCount < csvArray.count {
            quizArray = csvArray[quizCount].components(separatedBy:",")
            print("クイズカウント5番\(quizCount)")
            mondaiID = quizArray[10]
            print(mondaiID)
            let touroku = UserDefaults.standard.string(forKey: mondaiID)
            print(cellArray)
            //print("お気に入りフラグ3\(touroku!)")
            if touroku == "1" {
                cellArray += [quizArray[0]]
                mondaiIDArray += [quizArray[10]]
                print(cellArray)
                nextQuiz()//追加
            } else {
                nextQuiz()
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
            print("エラー")
        }
        return csvArray
    }

    //print("\(quizArray[10])")
    
    

    //テーブルの行数を指定するメソッド（必須）
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {

        return cellArray.count

     }
    //var i = 0
    //セルの中身を設定するメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath)
        
        cell.textLabel!.text = cellArray[indexPath.row]
        
        return cell

    }
    //var i = 0
    //セルがタップされた時の処理
    func tableView(_ okiniirilist: UITableView,didSelectRowAt indexPath: IndexPath){
        //cellNum = indexPath.row
        mondaiID = mondaiIDArray[indexPath.row]
        print(mondaiID)
//        print("問題配列\(mondaiIDArray.count)")
//        for _ in 1...mondaiIDArray.count{
//            if cellNum ==
//            print("aaa")
//        }
//        for_ in 0...mondaiIDArray.count {
//            print("あdjふぉいあjふぉいあd")
//        }
        //okiniirilist.deselectRow(at: indexPath, animated: false)
        //for文で分岐いける
//        if indexPath.row == 0 {
            performSegue(withIdentifier: "toQuizVC", sender: nil)
//            print("aaaaa")
//            //print(quizCount)
//        }
//        print("test\(indexPath)")//処理を記述
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let toQuizVC = segue.destination as! QuizViewController//エラー対策
        toQuizVC.mondaiID = mondaiID
        toQuizVC.fromBookmark = 1
//        resultVC.hantei = result
//        resultVC.kotae = quizArray[6]
//        resultVC.mondai = resultMondai
//        resultVC.correctCount1 = correctCount
//        resultVC.quizCount1 = quizCount
//        resultVC.mondaisuu1 = mondaisuu
//        resultVC.selectLevel1 = selectLevel
//        resultVC.okiniiri1 = quizArray[9]
//        resultVC.mondaiID = quizArray[10]
//        resultVC.mondaiIID = resultMondaiID
//        resultVC.owari1 = owari//次の問題があるのか判定
    }
//    extension ViewController: UITableViewDelegate {
//        func okiniirilist(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath){
//            //処理を記述
//        }
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

//extension ViewController: UITableViewDelegate {
//    func tableView(_ okiniirilist: UITableView,didSelectRowAt indexPath: IndexPath){
//        okiniirilist.deselectRow(at: indexPath, animated: false)
//        print("test")//処理を記述
//    }
//}
