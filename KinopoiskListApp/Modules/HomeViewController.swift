//
//  ViewController.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 13.03.2024.
//

import UIKit
import Foundation
import AlamofireImage

class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var kpSections: [KPItems] = []
    private var persons: [Person] = []
    private var categoryList: [String] {
        return DataManager.shared.getCategories()
    }
    private let sectionHeaderView = SectionHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupCollectionView()
        fetchData()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(KPSearchCell.self, 
                                forCellWithReuseIdentifier: KPSearchCell.reuseId)
        collectionView.register(CategoryCell.self,
                                forCellWithReuseIdentifier: CategoryCell.reuseId)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseId)
        
        collectionView.isHidden = true
    }
}

// MARK: - Setup layout
extension HomeViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment)
            -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return self.createSectionForListsOrPersons()
            case 1:
                return self.createCategoriesSection()
            default:
                return self.createSectionForListsOrPersons()
            }
        }
    
        return layout
    }
    
    private func createSectionForListsOrPersons() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(135), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 10, bottom: 10, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [headerElement]
        
        return section
    }
    
    private func createCategoriesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(30), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let innerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35))
        let innerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: innerGroupSize, subitems: [item])
        innerGroup.interItemSpacing = .fixed(10)
       
        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitems: [innerGroup])
        nestedGroup.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 10, bottom: 10, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, 
                                                                        elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [headerElement]
        
        return section
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            if kpSections.isEmpty {
                return 0
            }
            return kpSections[section].collections?.count ?? 0
        default:
            return categoryList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let collections = kpSections.first?.collections,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPSearchCell.reuseId,
              for: indexPath) as? KPSearchCell
            else {
                return UICollectionViewCell()
            }
            cell.configure(with: collections[indexPath.item])
            
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as? CategoryCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: categoryList[indexPath.item])
            
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPSearchCell.reuseId,
              for: indexPath) as? KPSearchCell
            else {
                return UICollectionViewCell()
            }
            cell.configure(with: persons[indexPath.item])
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseId,
            for: indexPath
        ) as? SectionHeaderView else {
            return UICollectionReusableView()
        }
        
        switch indexPath.section {
        case 0:
            sectionHeaderView.title.text = "Советуем посмотреть"
        case 1:
            sectionHeaderView.title.text = "Категории"
        default:
            sectionHeaderView.title.text = "Родились сегодня"
        }
        
        return sectionHeaderView
    }
}

// MARK: - Networking
extension HomeViewController {
    private func fetchData() {
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        NetworkingManager.shared.fetchData { [weak self] result in
            switch result {
            case .success(let value):
                if let value = value.kpItems {
                    if let persons = value.persons {
                        self?.persons = persons.filter({ person in
                            person.birthday.prefix(10) == Date().formatString()
                        })
                    } else {
                        self?.kpSections.append(value)
                    }
                }
                self?.collectionView.isHidden = false
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

