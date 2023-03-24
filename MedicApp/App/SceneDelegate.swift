//
//  SceneDelegate.swift
//  MedicApp
//
//  Created by Павел Кай on 09.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        var vc: UIViewController
        
//        if UserDefaults.standard.bool(forKey: "DidSkipOnboarding") {
//            vc = AuthViewController()
//        } else {
//            vc = OnboardingPageViewController()
//        }
        
        let nav = UINavigationController(rootViewController: MainTabBarViewController())
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = OrderViewController()
        window?.makeKeyAndVisible()
        
    }



}

