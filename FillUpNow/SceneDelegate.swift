//
//  SceneDelegate.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/03/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    // 소희
    func sceneDidBecomeActive(_ scene: UIScene) {
        if UIApplication.shared.applicationIconBadgeNumber != 0 {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}

