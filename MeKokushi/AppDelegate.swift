//
//  AppDelegate.swift
//  MeKokushi
//
//  Created by 具試験 on 2022/07/30.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // スキーマバージョン(新しくスキーマを追加したらこのバージョンを上げて)
    let version:UInt64 = 2
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // realmのマイグレーション
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
        
        
        do {
            let realm = try! Realm(fileURL: URL(string: Bundle.main.path(forResource: "default", ofType: "realm")!)!)
        } catch {
            print("Error initialising new realm, \(error)")
        }
        
        return true
    }
        
        func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            // Called when a new scene session is being created.
            // Use this method to select a configuration to create the new scene with.
            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        }
        
        func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

        }
        
        
    }
    

