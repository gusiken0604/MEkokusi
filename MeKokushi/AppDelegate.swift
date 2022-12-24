//
//  AppDelegate.swift
//  MeKokushi
//
//  Created by 具試験 on 2022/07/30.
//

import UIKit
import RealmSwift
//import GoogleMobileAds



@main
//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    //スキーマバージョン(新しくスキーマを追加したらこのバージョンを上げて)
    let version:UInt64 = 2
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //GADMobileAds.sharedInstance().start(completionHandler: nil)
        //GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        //realmのマイグレーション
                       let config = Realm.Configuration(
                         // スキーマバージョン設定
                         schemaVersion: version,

                         // 実際のマイグレーション処理　古いスキーマバージョンのRealmを開こうとすると自動的にマイグレーションが実行
                         migrationBlock: { migration, oldSchemaVersion in
                           // 初めてのマイグレーションの場合、oldSchemaVersionは0
                             if (oldSchemaVersion < self.version) {
                             // 変更点を自動的に認識しスキーマをアップデートする（ここで勝手にするから何も書かない）
                           }
                         })

                       // デフォルトRealmに新しい設定適用
                       Realm.Configuration.defaultConfiguration = config
        
        
        // アプリで使用するdefault.realmのパスを取得
//                let defaultRealmPath = Realm.Configuration.defaultConfiguration.fileURL!
//                // 初期データが入ったRealmファイルのパスを取得
//                let bundleRealmPath = Bundle.main.url(forResource: "default", withExtension: "realm")
//                // アプリで使用するRealmファイルが存在しない（= 初回利用）場合は、シードファイルをコピーする
//                if !FileManager.default.fileExists(atPath: defaultRealmPath.path) {
//                    do {
//                        try FileManager.default.copyItem(at: bundleRealmPath!, to: defaultRealmPath)
//                    } catch let error {
//                        print("error: \(error)")
//                    }
//                }

        
        
   //     let realm = try! Realm(fileURL: URL(string: Bundle.main.path(forResource: "default", ofType: "realm")!)!)
        do {
            //let realm = try Realm()
            let realm = try! Realm(fileURL: URL(string: Bundle.main.path(forResource: "default", ofType: "realm")!)!)
        } catch {
            print("Error initialising new realm, \(error)")
        }

        return true
    }

        // MARK: UISceneSession Lifecycle
        
        func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            // Called when a new scene session is being created.
            // Use this method to select a configuration to create the new scene with.
            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        }
        
        func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

        }
        
        
    }
    

