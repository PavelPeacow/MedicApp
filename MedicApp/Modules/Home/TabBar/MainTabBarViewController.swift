//
//  MainTabBarViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 20.03.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let analiz = UINavigationController(rootViewController: HomeViewController())
        analiz.tabBarItem.image = UIImage(named: "tab1")
        analiz.tabBarItem.title = "Анализы"
        
        let results = UINavigationController(rootViewController: ResultViewController())
        results.tabBarItem.image = UIImage(named: "tab2")
        results.tabBarItem.title = "Результаты"
        
        let chat = UINavigationController(rootViewController: ChatViewController())
        chat.tabBarItem.image = UIImage(named: "tab3")
        chat.tabBarItem.title = "Поддержка"
        
        let profile = UINavigationController(rootViewController: ChatViewController())
        profile.tabBarItem.image = UIImage(named: "tab4")
        profile.tabBarItem.title = "Профиль"
        
        setViewControllers([analiz, results, chat, profile], animated: true)
    }
    


}
