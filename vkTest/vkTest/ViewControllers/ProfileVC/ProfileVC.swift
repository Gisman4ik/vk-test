//
//  ProfileVC.swift
//  vkTest
//
//  Created by Artur Radziukhin on 27.06.21.
//

import UIKit
import ImageSlideshow

enum ProfileViewModel: CaseIterable {
    case mainInfo
    case additionalInfo
    case friends
    //    case wall
}


class ProfileVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    
    var profile: UserModel?
    var userFriends: FriendsModel?
    var tableModel = ProfileViewModel.allCases
    var profileID: Int?
    var slideshow: ImageSlideshow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCell([MainInfoCell.self, AdditionalInfoCell.self,FriendsCell.self])
        getProfileInfo()
    }
    
    func getProfileInfo() {
        NetworkManager.shared.getUserInfo(id: profileID) { [weak self] result in
            self?.profile = result.response?.first
            self?.title = self?.profile?.screenName
            self?.loadingView.isHidden = true
            self?.tableView.reloadData()
        } failure: { error in
            print(error)
        }
        NetworkManager.shared.getUserFriends(id: profileID) { [weak self] result in
            self?.userFriends = result.response
            self?.tableView.reloadData()
        } failure: { error in
            print(error)
        }

    }
}

extension ProfileVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableModel[indexPath.row] {
        case .mainInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MainInfoCell.self), for: indexPath)
            guard let mainInfoCell = cell as? MainInfoCell else {return cell}
            mainInfoCell.fullscreenDelegate = self
            mainInfoCell.profile = profile
            return mainInfoCell
        case .additionalInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AdditionalInfoCell.self), for: indexPath)
            guard let additionalCell = cell as? AdditionalInfoCell else {return cell}
            additionalCell.profile = profile
            return additionalCell
        case .friends:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FriendsCell.self), for: indexPath)
            guard let friendsCell = cell as? FriendsCell else {return cell}
            friendsCell.friends = userFriends
            friendsCell.openUserByID = {[weak self] id in
                guard let userProfileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ProfileVC.self)) as? ProfileVC else {return}
                userProfileVC.profileID = id
                self?.navigationController?.pushViewController(userProfileVC, animated: true)
            }
            return friendsCell
        }
    }
}

extension ProfileVC: ImageFullScreen {
    
    func setGestureFullSlideShow() {
         let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
         guard let slideShow = slideshow else {return}
         slideShow.addGestureRecognizer(gestureRecognizer)
     }
     
     @objc func didTap() {
         guard let slideShow = slideshow else {return}
        let fullScreenController = slideShow.presentFullScreenController(from: self)
         fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator()
     }
    
    func openFullScreen(_ slideshow: ImageSlideshow) {
        self.slideshow = slideshow
        self.setGestureFullSlideShow()
    }
}
