//
//  ReuseIdentifier.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 16.04.2024.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseId: String { get }
}

extension ReuseIdentifiable {
    static var reuseId: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {
}

extension UITableViewHeaderFooterView: ReuseIdentifiable {
}

extension UICollectionReusableView: ReuseIdentifiable {
}

extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseId,
                for: indexPath) as? T else {
            fatalError("Can't dequeue")
        }
        return cell
    }

    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        self.register(cellType, forCellWithReuseIdentifier: cellType.reuseId)
    }
}

extension UITableView {
    func dequeueCell<T: UITableViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseId,
                for: indexPath) as? T else {
            fatalError("Can't dequeue")
        }
        return cell
    }

    func register<T: UITableViewCell>(_ cellType: T.Type) {
        self.register(cellType, forCellReuseIdentifier: cellType.reuseId)
    }
}
