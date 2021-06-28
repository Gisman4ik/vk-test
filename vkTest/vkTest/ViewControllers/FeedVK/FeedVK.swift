//
//  FeedVK.swift
//  vkTest
//
//  Created by Artur Radziukhin on 26.06.21.
//

import UIKit
import ImageSlideshow

enum FeedViewModel: CaseIterable {
    case header
    case text
    case media
    case footer
    
    static func getModel(newsFeedData: NewsFeedModel?) -> [[FeedViewModel]] {
        guard let newsFeedData = newsFeedData  else {return []}
        var result: [[FeedViewModel]] = []
        for _ in newsFeedData.items {
            result += [FeedViewModel.allCases]
        }
        return result
    }
}

class FeedVK: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    
    var newsFeedData: NewsFeedModel?
    var tableModel: [[FeedViewModel]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCell([HeaderCell.self, TextCell.self, MediaCell.self, FooterCell.self])
        getNewsFeed()
    }
    
    func getNewsFeed() {
        NetworkManager.shared.getNewsFeed { [weak self] result in
            self?.newsFeedData = result.response
            self?.tableModel = FeedViewModel.getModel(newsFeedData: self?.newsFeedData)
            self?.loadingView.isHidden = true
            self?.tableView.reloadData()
        } failure: { error in
            print(error)
        }
    }
}

extension FeedVK: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel[section].count
    }
}

extension FeedVK: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsFeedData = newsFeedData
        let post = newsFeedData?.items[indexPath.section]
        var postAuthor: PostAuthor? {
            if let postID = post?.sourceID, postID > 0 {
                return newsFeedData?.profiles.first(where: { value -> Bool in
                    value.id == abs(postID)
                })
            } else if let postID = post?.sourceID, postID < 0 {
                return newsFeedData?.groups.first(where: { value -> Bool in
                    value.id == abs(postID)
                })
            } else {return nil}
        }
        switch tableModel[indexPath.section][indexPath.row] {
        case .header :
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderCell.self), for: indexPath)
            guard let headerCell = cell as? HeaderCell else {return cell}
            headerCell.post = post
            headerCell.postAuthor = postAuthor
            return headerCell
        case .text :
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextCell.self), for: indexPath)
            guard let textCell = cell as? TextCell else {return cell}
            textCell.text = post?.text
            return textCell
        case .media :
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MediaCell.self), for: indexPath)
            guard let mediaCell = cell as? MediaCell else {return cell}
            mediaCell.fullscreenResponder = self
            mediaCell.media = post?.attachments
            return mediaCell
        case .footer :
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FooterCell.self), for: indexPath)
            guard let footerCell = cell as? FooterCell else {return cell}
            footerCell.post = post
            return footerCell
        }
    }
}
