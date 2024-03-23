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
    private var kpSectionList: [KPSection<KPCollection>] = []
    private var dataSource: UICollectionViewDiffableDataSource<KPSection<KPCollection>, KPCollection>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupCollectionView()
        fetchMovies()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
        view.addSubview(collectionView)
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseId)
    }
    
    // MARK: - Manage the data in UICV
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<KPSection<KPCollection>,
            KPCollection>(collectionView: collectionView, cellProvider: { (collectionView,
               indexPath, item) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseId, for: indexPath) as? HomeCell
                cell?.configure(with: item)
                return cell
            })
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<KPSection<KPCollection>, KPCollection>()
        snapshot.appendSections(kpSectionList)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(135), heightDimension: .estimated(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        kpSectionList[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeCell.reuseId,
            for: indexPath
        ) as? HomeCell else {
            return UICollectionViewCell()
        }
        
        let collection = kpSectionList.items[indexPath.item]
        cell.configure(with: collection)
        
        return cell
    }
}

// MARK: - Networking
extension HomeViewController {
    private func fetchMovies() {
        NetworkingManager.shared.fetchData(KPSection<KPCollection>.self) { [weak self] result in
            switch result {
            case .success(let collectionList):
                self?.kpSectionList.append(collectionList)
                //self?.collectionView.reloadSections(IndexSet(integer: 1))
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchImage(with url: String) -> UIImage? {
        if let imageData = NetworkingManager.shared.fetchImageData(from: url) {
            return UIImage(data: imageData) ?? nil
        } else {
            return nil
        }
    }
}

