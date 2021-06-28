//
//  FriendCollectionCell.swift
//  vkTest
//
//  Created by Artur Radziukhin on 28.06.21.
//

import UIKit

class FriendCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userFirstName: UILabel!
    @IBOutlet weak var userLastName: UILabel!
    
    var user: UserModel? {
        didSet {
            setUserInfo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUserInfo() {
        guard let user = user else {return}
        
        userPhoto.sd_setImage(with: URL(string: user.photoMax), completed: nil)
        
        userFirstName.text = user.firstName
        
        userLastName.text = user.lastName
    }
    
}
