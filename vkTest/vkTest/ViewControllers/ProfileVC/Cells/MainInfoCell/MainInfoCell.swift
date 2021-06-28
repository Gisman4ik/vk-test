//
//  MainInfoCell.swift
//  vkTest
//
//  Created by Artur Radziukhin on 28.06.21.
//

import UIKit
import SDWebImage

class MainInfoCell: UITableViewCell {

    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileStatus: UILabel!
    @IBOutlet weak var onlineStatus: UILabel!
    
    var profile: UserModel? {
        didSet {
            setProfileInfo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setProfileInfo() {
        guard let profile = profile else {return}
        
        profilePhoto.sd_setImage(with: URL(string: profile.photoMax), completed: nil)
        
        profileName.text = profile.firstName + " " + profile.lastName
        
        if !profile.status.isEmpty {
            profileStatus.text = profile.status
            profileStatus.textColor = .black
        } else {
            profileStatus.text = "Установить статус"
            profileStatus.textColor = .systemBlue
        }
        
        if profile.online == 1 {
            onlineStatus.text = "online"
        } else {
            onlineStatus.text = "offline"
        }
    }
}
