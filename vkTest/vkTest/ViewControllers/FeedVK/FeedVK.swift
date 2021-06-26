//
//  FeedVK.swift
//  vkTest
//
//  Created by Artur Radziukhin on 26.06.21.
//

import UIKit

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
    
    var newsFeedData: NewsFeedModel?
    var tableModel: [[FeedViewModel]] { FeedViewModel.getModel(newsFeedData: newsFeedData)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsFeed()
        tableView.registerCell([HeaderCell.self, TextCell.self, MediaCell.self, FooterCell.self])
    }
    
    func getNewsFeed() {
        NetworkManager.shared.getNewsFeed { [weak self] result in
            self?.newsFeedData = result.response
            self?.tableView.reloadData()
        } failure: { error in
            print(error)
        }
    }
}

extension FeedVK: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableModel[indexPath.section][indexPath.row] {
        case .header :
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderCell.self), for: indexPath)
            guard let headerCell = cell as? HeaderCell else {return cell}
            return headerCell
        case .text :
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextCell.self), for: indexPath)
            guard let textCell = cell as? TextCell else {return cell}
            return textCell
        case .media :
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MediaCell.self), for: indexPath)
            guard let mediaCell = cell as? MediaCell else {return cell}
            return mediaCell
        case .footer :
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FooterCell.self), for: indexPath)
            guard let footerCell = cell as? FooterCell else {return cell}
            return footerCell
        }
    }
}
