//
//  ViewController.swift
//  vkTest
//
//  Created by Artur Radziukhin on 26.06.21.
//

import UIKit

class Authenticator: UIViewController {

    let authManager = AuthorizationManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    @IBAction func signInVK(_ sender: Any) {
        authManager.wakeUpSession()
        
        
        // Открывал поверх окна авторизации другой контроллер и данные поэтому не приходили:))
//       ||
//       \/
        
//        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) ?? UIApplication.shared.windows.first
//        keyWindow?.rootViewController = MainTabBar()
    }
}

