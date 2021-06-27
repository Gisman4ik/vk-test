//
//  TextCell.swift
//  vkTest
//
//  Created by Artur Radziukhin on 26.06.21.
//

import UIKit

class TextCell: UITableViewCell {

    @IBOutlet weak var postTextLabel: UILabel!
    
    var text: String? {
        didSet {
            postTextLabel.text = text ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
