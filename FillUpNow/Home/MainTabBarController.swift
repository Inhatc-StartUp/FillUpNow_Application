//
//  MainTabBarController.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/03/25.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1
        tabBar.backgroundColor = .systemBackground
    }
}
