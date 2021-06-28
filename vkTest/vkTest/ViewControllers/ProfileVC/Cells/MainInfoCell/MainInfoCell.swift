//
//  MainInfoCell.swift
//  vkTest
//
//  Created by Artur Radziukhin on 28.06.21.
//

import UIKit
import SDWebImage
import ImageSlideshow

class MainInfoCell: UITableViewCell {

    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileStatus: UILabel!
    @IBOutlet weak var onlineStatus: UILabel!
    
   weak var fullscreenDelegate: ImageFullScreen?
    
    var profile: UserModel? {
        didSet {
            setProfileInfo()
            setProfilePhoto()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        slideshow.setImageInputs([])
    }
    
    func setProfilePhoto() {
        guard let url = profile?.photoMax, let source = SDWebImageSource(urlString: url) else {return}
        slideshow.setImageInputs([source])
        slideshow.circular = false
        slideshow.draggingEnabled = false
        slideshow.activityIndicator = DefaultActivityIndicator()
        fullscreenDelegate?.openFullScreen(slideshow)
    }
    
    func setProfileInfo() {
        guard let profile = profile else {return}
        
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

protocol ImageFullScreen: AnyObject {
    func openFullScreen(_ slideshow: ImageSlideshow)
}
