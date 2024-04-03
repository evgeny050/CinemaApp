//
//  CellFactory.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 03.04.2024.
//

import UIKit

final class CellFactory {
    
    static func collectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifire)
        collectionView.backgroundColor = .black
        return collectionView
    }
    
}
    
