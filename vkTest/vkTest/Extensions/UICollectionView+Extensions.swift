//
//  UICollectionView+Extensions.swift
//  vkTest
//
//  Created by Artur Radziukhin on 28.06.21.
//

import UIKit

extension UICollectionView {
    func registerCell(_ cellsClases: [AnyClass]) {
        cellsClases.forEach { cellClass in
            let nib = UINib(nibName: String(describing: cellClass.self), bundle: nil)
            self.register(nib, forCellWithReuseIdentifier: String(describing: cellClass.self))
        }
    }
}
