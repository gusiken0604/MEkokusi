//
//  MyTabBarController.swift
//  MeKokushi
//
//  Created by 具志堅 on 2022/10/07.
//

import UIKit

class MyTabBarController: UITabBarController,UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is BookmarkViewController {

        } else {
 
        }
    }
}
