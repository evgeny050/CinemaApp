//
//  CellFactory.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 03.04.2024.
//
import UIKit

enum SectionKind: Int, CaseIterable {
    case collections
    case movies
    case facts
    case personInfo
    case categories
    
    var itemHeight: NSCollectionLayoutDimension {
        switch self {
        case .collections:
            return .estimated(190)
        case .movies:
            return .estimated(180)
        default:
            return .fractionalHeight(1.0)
        }
    }
    
    var itemWidth: NSCollectionLayoutDimension {
        switch self {
        case .categories:
            return .estimated(80)
        default:
            return .fractionalWidth(1.0)
        }
    }

    var groupHeight: NSCollectionLayoutDimension {
        switch self {
        case .collections, .movies:
            return .estimated(190)
        default:
            return .absolute(180)
        }
    }
    
    var groupWidth: NSCollectionLayoutDimension {
        switch self {
        case .collections:
            return .absolute(135)
        case .movies:
            return .absolute(130)
        case .facts:
            return .fractionalWidth(0.7)
        default:
            return .fractionalWidth(1.0)
        }
    }
    
    var sectionInterGroupSpacing: CGFloat {
        switch self {
        case .movies:
            return 16
        default:
            return 10
        }
    }
    
    var sectionInsets: NSDirectionalEdgeInsets {
        switch self {
        case .personInfo:
            return NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        default:
            return NSDirectionalEdgeInsets(top: 12, leading: 10, bottom: 10, trailing: 10)
        }
    }
    
    var headerHeight: NSCollectionLayoutDimension {
        switch self {
        case .movies, .facts:
            return .absolute(40)
        default:
            return .absolute(20)
        }
    }
}

final class CellFactory {
    static func collectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        return collectionView
    }
    
    static func createSection(for sectionKind: SectionKind) -> NSCollectionLayoutSection {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: sectionKind.headerHeight)
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: sectionKind.itemWidth,
            heightDimension: sectionKind.itemHeight
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: sectionKind.groupWidth, heightDimension: sectionKind.groupHeight)
        let group = (sectionKind == .categories) ? 
                    createGroupForCategories(with: item) :
                    NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        if sectionKind != .personInfo {
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = sectionKind.sectionInterGroupSpacing
            section.boundarySupplementaryItems = [headerElement]
        }
        section.contentInsets = sectionKind.sectionInsets
        
        return section
    }
    
    static func createGroupForCategories(with item: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        let innerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35))
        let innerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: innerGroupSize, subitems: [item])
        innerGroup.interItemSpacing = .fixed(10)
       
        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(90))
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitems: [innerGroup])
        nestedGroup.interItemSpacing = .fixed(10)
        
        return nestedGroup
    }
}
