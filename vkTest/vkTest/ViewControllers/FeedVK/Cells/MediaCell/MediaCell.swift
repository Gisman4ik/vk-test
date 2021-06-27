//
//  MediaCell.swift
//  vkTest
//
//  Created by Artur Radziukhin on 26.06.21.
//

import UIKit
import ImageSlideshow

class MediaCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lineViewHeight: NSLayoutConstraint!
    
    var photoView: PhotoView?
    var media: [Attachment]? {
        didSet {
            setMediaContent()
        }
    }
    
    override func prepareForReuse() {
        photoView?.removeFromSuperview()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lineViewHeight.constant = 0.5
    }
    
    func setMediaContent() {
        guard let media = media else {return}
        let photos = media.filter({$0.type == "photo"})
        if !photos.isEmpty {
            let photosArray = photos.map({$0.photo})
            let photosSizes = photosArray.compactMap({$0?.sizes.last})
            let photosURLs = photosSizes.compactMap({$0.url})
            let imgMaxHeight = photosSizes.max(by: {$0.height > $1.height})
            let aspectRatio = Double(imgMaxHeight!.height) / Double(imgMaxHeight!.width)
            let width = UIScreen.main.bounds.width
            mainViewHeight.constant = width *  CGFloat(aspectRatio)
            photoView = PhotoView.init(frame: mainView.bounds, imagesURLs: photosURLs)
            guard let sPhotoView = photoView else {return}
            mainView.addSubview(sPhotoView)
            sPhotoView.translatesAutoresizingMaskIntoConstraints = false
            let photoViewConstraints = [
                sPhotoView.topAnchor.constraint(equalTo: mainView.topAnchor),
                sPhotoView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
                sPhotoView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
                sPhotoView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
            ]
            NSLayoutConstraint.activate(photoViewConstraints)
        }
    }
}
