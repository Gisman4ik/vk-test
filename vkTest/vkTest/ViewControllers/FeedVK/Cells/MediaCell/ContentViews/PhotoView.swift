//
//  PhotoView.swift
//  vkTest
//
//  Created by Artur Radziukhin on 27.06.21.
//

import UIKit
import ImageSlideshow

class PhotoView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var slideshow: ImageSlideshow!
    var fullscreenResponder: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    convenience init (frame: CGRect, imagesURLs: [String], fullscreenResponder: UIViewController?) {
        self.init(frame: frame)
        self.fullscreenResponder = fullscreenResponder
        setGestureFullSlideShow()
        var sdWebImageSource: [SDWebImageSource] = []
        for urlString in imagesURLs {
            let source = SDWebImageSource(urlString: urlString)
            if let sdWebSource = source {
                sdWebImageSource.append(sdWebSource)
            }
        }
        slideshow.setImageInputs(sdWebImageSource)
        slideshow.activityIndicator = DefaultActivityIndicator()
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: PhotoView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func setGestureFullSlideShow() {
         let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
         slideshow.addGestureRecognizer(gestureRecognizer)
     }
     
     @objc func didTap() {
        guard let vc = fullscreenResponder else {return}
        let fullScreenController = slideshow.presentFullScreenController(from: vc)
         fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator()
     }
}
