//
//  UITableView+Extensions.swift
//  vkTest
//
//  Created by Artur Radziukhin on 26.06.21.
//

import UIKit

extension UITableView {
    func registerCell(_ cellsClases: [AnyClass]) {
        cellsClases.forEach { cellClass in
            let nib = UINib(nibName: String(describing: cellClass.self), bundle: nil)
            self.register(nib, forCellReuseIdentifier: String(describing: cellClass.self))
        }
    }
}
