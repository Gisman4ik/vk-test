//
//  HeaderCell.swift
//  vkTest
//
//  Created by Artur Radziukhin on 26.06.21.
//

import UIKit
import SDWebImage

class HeaderCell: UITableViewCell {

    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var postDate: UILabel!
    
    var post: Item? {
        didSet {
            reloadCell()
        }
    }
    var postAuthor: PostAuthor? {
        didSet {
            reloadCell()
        }
    }
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM 'в' HH:mm "
        return dateFormatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func reloadCell() {
        guard let post = post, let postAuthor = postAuthor else {return}
        let date = Date(timeIntervalSince1970: TimeInterval(post.date))
        authorLabel.text = postAuthor.name
        postDate.text = dateFormatter.string(from: date)
        headerImage.sd_setImage(with: URL(string: postAuthor.photo), placeholderImage: UIImage(systemName: "person"), options: [], completed: nil)
    }
    
}
