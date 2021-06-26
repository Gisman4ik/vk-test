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
    }
    
}

