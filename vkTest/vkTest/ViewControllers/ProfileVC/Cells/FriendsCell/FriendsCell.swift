//
//  FriendsCell.swift
//  vkTest
//
//  Created by Artur Radziukhin on 28.06.21.
//

import UIKit

class FriendsCell: UITableViewCell {

    @IBOutlet weak var friendsCount: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    var openUserByID: ((_ id: Int) -> Void)?
    
    var friends: FriendsModel? {
        didSet {
            collectionView.reloadData()
            friendsCount.text = "\(friends?.count ?? 0)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCell([FriendCollectionCell.self])
    }
}

extension FriendsCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let action = openUserByID, let id = friends?.friends[indexPath.row].id {
            action(id)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 90)
    }
}

extension FriendsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FriendCollectionCell.self), for: indexPath)
        guard let friendColletionCell = cell as? FriendCollectionCell else {return cell}
        friendColletionCell.user = friends?.friends[indexPath.row]
        return friendColletionCell
    }
}
