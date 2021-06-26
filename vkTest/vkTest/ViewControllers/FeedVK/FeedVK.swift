//
//  FeedVK.swift
//  vkTest
//
//  Created by Artur Radziukhin on 26.06.21.
//

import UIKit

class FeedVK: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.getNewsFeed { result in
            print(result.response?.items.count)
        } failure: { error in
            print(error)
        }


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
