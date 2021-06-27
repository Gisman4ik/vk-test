//
//  ProfileVC.swift
//  vkTest
//
//  Created by Artur Radziukhin on 27.06.21.
//

import UIKit

class ProfileVC: UIViewController {
    
    var profile: ProfileModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileInfo()
    }
    
    func getProfileInfo() {
        NetworkManager.shared.getProfileInfo { [weak self] result in
            self?.profile = result.response
        } failure: { error in
            print(error)
        }

    }
}
