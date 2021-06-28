//
//  AdditionalInfoCell.swift
//  vkTest
//
//  Created by Artur Radziukhin on 28.06.21.
//

import UIKit

class AdditionalInfoCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityIcon: UIImageView!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var occupationIcon: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followersIcon: UIImageView!
    @IBOutlet weak var bdateLabel: UILabel!
    @IBOutlet weak var bdateIcon: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryIcon: UIImageView!
    
    
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
        if !profile.bdate.isEmpty {
            bdateLabel.text = "День рождения: \(profile.bdate)"
        } else {
            bdateLabel.isHidden = true
            bdateIcon.isHidden = true
        }
        
        if let city = profile.city, !city.title.isEmpty {
            cityLabel.text = "Город: " + city.title
        } else {
            cityLabel.isHidden = true
            cityIcon.isHidden = true
        }
        
        if let country = profile.country, !country.title.isEmpty {
            countryLabel.text = "Страна: " + country.title
        } else {
            countryLabel.isHidden = true
            countryIcon.isHidden = true
        }
        
        if let occupation = profile.occupation, !occupation.name.isEmpty {
            if occupation.type == "work" {
                occupationLabel.text = "Место работы: \(occupation.name)"
            } else if occupation.type == "school" || occupation.type == "university" {
                occupationLabel.text = "Образование: \(occupation.name)"
            }
        } else {
            occupationLabel.isHidden = true
            occupationIcon.isHidden = true
        }
        
        if profile.followersCount > 0 {
            followersLabel.text = "\(profile.followersCount) подписчик(а)"
        } else {
            followersLabel.isHidden = true
            followersIcon.isHidden = true
        }
    }
}
