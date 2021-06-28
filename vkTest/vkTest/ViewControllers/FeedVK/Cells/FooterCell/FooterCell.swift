//
//  FooterCell.swift
//  vkTest
//
//  Created by Artur Radziukhin on 26.06.21.
//

import UIKit

class FooterCell: UITableViewCell {

    @IBOutlet weak var likesButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var repostsButton: UIButton!
    @IBOutlet weak var viewsLabel: UILabel!
    
    var post: Item? {
        didSet {
            reloadCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func reloadCell() {
        guard let post = post else {return}
        likesButton.setTitle("\(post.likes?.count ?? 0)", for: .normal)
        commentsButton.setTitle("\(post.comments?.count ?? 0)", for: .normal)
        repostsButton.setTitle("\(post.reposts?.count ?? 0)", for: .normal)
        if let views = post.views?.count {
            var viewStr = String(views)
            if views > 1000 {viewStr = String(format: "%.1f", Double(views) / 1000.0) + "K"}
            viewsLabel.text = "\(viewStr)"
        }
    }
}
