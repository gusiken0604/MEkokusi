//
//  BookmackViewController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/08/28.
//

import UIKit

class BookmarkViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarDelegate,UITabBarControllerDelegate{
    
    var csvArray: [String] = []//CSVを入れる箱
    var quizArray: [String] = []
    var quizCount = 0
    var mondaiID = "0"
    var touroku = "0"
    var cellArray:[String] = []
    var mondaiIDArray:[String] = []//問題ID格納してquizviewへ受け渡す
    
    @IBOutlet var bookmark: UITabBar!//UITabBarItemから変更
    
    @IBOutlet weak var okiniirilist: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.loadView()
//        self.viewDidLoad()
        //self.delegate = self
        //tabBarController?.tabBar.isHidden = true//tabBar非表示


        okiniirilist.delegate = self
        okiniirilist.dataSource = self
        
        
//        func tabBar(_ tabBar: UITabBar,didSelect item: UITabBarItem) {
//            if (item.tag == 1){
//                print("aaaaaa")
//            } else {
//                print("bbbbbbb")
//            }
//        }
//        func tabBar(tabBar: UITabBar,didSelectItem item: UITabBarItem) {
//                switch item.tag {
//                case 1 :
//                    print("aaaaaaa")
//                default:
//                    print("bbbbbb")
//                }
//            }

    }// viewDidLoad終わり
//func tabBar(tabBar: UITabBar,didSelectItem item: UITabBarItem) {
//        switch item.tag {
//        case 1 :
//            print("aaaaaaa")
//        default:
//            print("bbbbbb")
//        }
//    }
    //画面が遷移する直前に実行
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
            //self.navigationItem.hidesBackButton = true
//self.navigationItem.setHidesBackButton(false, animated: false)
//        title = "ブックマーク"
//       self.navigationItem.setHidesBackButton(false, animated: false)

        cellArray = []
        quizCount = 0
        mondaiIDArray = []
//        print("お気に入りフラグ1\(touroku)")
        //print("\(touroku1!)")
        //csv読み込むブロック
        csvArray = loadCSV(fileName: "quiz0")//quiz0.csv固定
        quizArray = csvArray[quizCount].components(separatedBy: ",")
//        print("クイズカウント1番\(quizCount)")
        mondaiID = quizArray[10]
        let touroku = UserDefaults.standard.string(forKey: mondaiID)
//        print("お気に入りフラグ2\(touroku!)")
//        print(quizArray[10])
        
        if touroku == "1" {
            cellArray += [quizArray[0]]
            mondaiIDArray += [quizArray[10]]
//            print("お気に入りフラグifff\(touroku!)")
//            print("クイズカウント2番\(quizCount)")//0
            nextQuiz()
        } else {
            nextQuiz()//修正前
        }
        okiniirilist.reloadData()
//        print("画面遷移")
        
        //navigationController?.isNavigationBarHidden = true
        
        //navigationController?.isNavigationBarHidden = false
        //navigationController?.navigationBar.isHidden = false
    }//ViewWillAppear終了
    
    //次の問題を表示させるブロック
    func nextQuiz(){
        quizCount += 1
        //print("クイズカウント3番\(quizCount)")//1
        if quizCount < csvArray.count {
            quizArray = csvArray[quizCount].components(separatedBy:",")
//            print("クイズカウント5番\(quizCount)")
            mondaiID = quizArray[10]
//            print(mondaiID)
            let touroku = UserDefaults.standard.string(forKey: mondaiID)
//            print(cellArray)
            //print("お気に入りフラグ3\(touroku!)")
            if touroku == "1" {
                cellArray += [quizArray[0]]
                mondaiIDArray += [quizArray[10]]
//                print(cellArray)
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

    //テーブルの行数を指定するメソッド（必須）
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        
        return cellArray.count
        
     }

    //セルの中身を設定するメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath)
        
        cell.textLabel!.text = cellArray[indexPath.row]
        
        return cell

    }

    //セルがタップされた時の処理
    func tableView(_ okiniirilist: UITableView,didSelectRowAt indexPath: IndexPath){
        
        mondaiID = mondaiIDArray[indexPath.row]
        print(mondaiID)
        performSegue(withIdentifier: "toQuizVC", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let toQuizVC = segue.destination as! QuizViewController//エラー対策
        toQuizVC.mondaiID = mondaiID
        toQuizVC.fromBookmark = 1

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
