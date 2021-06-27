//
//  MainTabBar.swift
//  vkTest
//
//  Created by Artur Radziukhin on 27.06.21.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = UIColor.systemBlue
        self.tabBar.unselectedItemTintColor = .lightGray
        self.viewControllers = getVCs()
    }

    func getVCs() -> [UIViewController] {
        var controllers = [UIViewController]()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let feedVK = storyboard.instantiateViewController(withIdentifier: String(describing: FeedVK.self)) as? FeedVK else {
            return controllers
        }
        feedVK.title = "Главная"
        feedVK.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house"), tag: 0)
        let feedVKVCNav = UINavigationController(rootViewController: feedVK)
        feedVKVCNav.navigationBar.barTintColor = .white
        
        guard let profileVC = storyboard.instantiateViewController(withIdentifier: String(describing: ProfileVC.self)) as? ProfileVC else {
            return controllers
        }
        profileVC.title = "Профиль"
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 3)
        profileVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        let profileVCNav = UINavigationController(rootViewController: profileVC)
        profileVCNav.navigationBar.barTintColor = .white
        controllers += [feedVKVCNav, profileVCNav]
        
        return controllers
    }
}
