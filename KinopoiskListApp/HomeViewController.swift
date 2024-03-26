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
    private var kpSectionList: [String: Any] = [:]
    private var kpList: [KPItems] = []
    //private var dataSource: UICollectionViewDiffableDataSource<KPSection<KPCollection>, KPCollection>?
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
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseId)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseId)
    }
    
    // MARK: - Manage the data in UICV
//    private func createDataSource() {
//        dataSource = UICollectionViewDiffableDataSource<KPSection<KPCollection>,
//            KPCollection>(collectionView: collectionView, cellProvider: { (collectionView,
//               indexPath, item) -> UICollectionViewCell? in
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseId, for: indexPath) as? HomeCell
//                cell?.configure(with: item)
//                return cell
//            })
//    }
//    
//    private func reloadData() {
//        var snapshot = NSDiffableDataSourceSnapshot<KPSection<KPCollection>, KPCollection>()
//        snapshot.appendSections(kpSectionList)
//        
//        for section in kpSectionList {
//            snapshot.appendItems(section.items, toSection: section)
//        }
//        
//        dataSource?.apply(snapshot)
//    }
    
    // MARK: - Setup layout
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment)
            -> NSCollectionLayoutSection? in
            return self.createFirstSection()
        }
    
        return layout
    }
    
    private func createFirstSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(135), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        headerElement.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        section.boundarySupplementaryItems = [headerElement]
        
        return section
    }

}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if kpList.count > 0 {
            return kpList[section].collections?.count ?? (kpList[section].movies?.count ?? 0)
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let collections = kpList["collections"] as? [Collection],
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseId,
//            for: indexPath) as? HomeCell
//        else {
//            return UICollectionViewCell()
//        }
        guard let collections = kpList.first?.collections,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseId,
          for: indexPath) as? HomeCell
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: collections[indexPath.item])
        return cell
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
        
        sectionHeaderView.title.text = "Советуем посмотреть"
        
        return sectionHeaderView
    }
}

// MARK: - Networking
extension HomeViewController {
    private func fetchData() {
        NetworkingManager.shared.fetchData { [weak self] result in
            switch result {
            case .success(let value):
                //self?.kpSectionList["collections"] = collectionList.collections
                //self?.collectionView.reloadSections(IndexSet(integer: 1))
                if let value =  value.kpItems {
                    self?.kpList.append(value)
                }
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

