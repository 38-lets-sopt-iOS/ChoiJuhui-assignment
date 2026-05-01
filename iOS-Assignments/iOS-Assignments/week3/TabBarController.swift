//
//  TabBarController.swift
//  iOS-Assignments
//
//  Created by h2e on 5/1/26.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 26.0, *) {
            tabBar.isTranslucent = false
        }
        
        setTabBar()
        
        tabBar.isTranslucent = false
        
        let firstViewController = MainViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "구독", image: .subscribe, tag: 0)
        
        let secondViewController = UIViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "개별 구매", image: .category, tag: 1)
        
        let thirdViewController = UIViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "웹툰", image: .wallet, tag: 2)
        
        let forthViewController = UIViewController()
        forthViewController.tabBarItem = UITabBarItem(title: "찾기", image: .search, tag: 3)
        
        let fifthViewController = UIViewController()
        fifthViewController.tabBarItem = UITabBarItem(title: "보관함", image: .folder, tag: 4)
        
        self.viewControllers = [firstViewController, secondViewController, thirdViewController, forthViewController, fifthViewController]
    }
    
    private func setTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.shadowColor = .clear
        
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray
        ]
        
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }

}
