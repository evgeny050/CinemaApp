//
//  DetailViewController.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 30.03.2024.
//

import UIKit
import SkeletonView

final class PersonDetailViewController: UIViewController {
    // MARK: - Properties
    private lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
    }()
    
    private let sectionHeaderView = SectionHeaderView()
    
    var person: Person!
    private var movies: [Movie] = []

    // MARK: - Initialization
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupCollectionView()
        showSkeletonAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Skeleton View
    private func showSkeletonAnimation() {
        collectionView.isSkeletonable = true
        collectionView.showAnimatedGradientSkeleton()
    }
    
    // MARK: - Setup the Collection View
    private func setupCollectionView() {
        //collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PersonInfoCell.self,
                                forCellWithReuseIdentifier: PersonInfoCell.reuseId)
        collectionView.register(KPItemCell.self,
                                forCellWithReuseIdentifier: KPItemCell.reuseId)
        collectionView.register(CategoryCell.self,
                                forCellWithReuseIdentifier: CategoryCell.reuseId)
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseId
        )
    }
}

// MARK: - Setup UICVCompositionalLayout
extension PersonDetailViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment)
            -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return self.createSectionForPersonInfo()
            case 1:
                return self.createSectionForMoviesOfPerson()
            case 2:
                return self.createSectionForFacts()
            //case 3:
               // return self.createSectionForProfessions()
            default:
                return self.createSectionForFacts()
                //return self.createSectionForFilmography()
            }
        }
        //layout.collectionView?.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
    
        return layout
    }
    
    func createSectionForPersonInfo() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    
    func createSectionForMoviesOfPerson() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(180))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(130), heightDimension: .estimated(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 10, bottom: 10, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [headerElement]
        
        return section
    }
    
    func createSectionForFacts() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 10, bottom: 10, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [headerElement]
        
        return section
    }
    
//    func createSectionForProfessions() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(30), heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.interItemSpacing = .fixed(10)
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 10, bottom: 10, trailing: 10)
//        
//        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))
//        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
//                                                                        elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//        section.boundarySupplementaryItems = [headerElement]
//        
//        return section
//    }
//    
//    func createSectionForFilmography() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(140))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 10, bottom: 10, trailing: 10)
//        
//        return section
//    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PersonDetailViewController: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate {
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 3
        }
    }
    
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
        ) -> SkeletonView.ReusableCellIdentifier {
        switch indexPath.section {
        case 0:
            return PersonInfoCell.reuseId
        case 1:
            return KPItemCell.reuseId
        default:
            return CategoryCell.reuseId
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView,
                                prepareCellForSkeleton cell: UICollectionViewCell,
                                at indexPath: IndexPath) {
        cell.isSkeletonable = true
    }
    
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        supplementaryViewIdentifierOfKind: String,
        at indexPath: IndexPath
    ) -> ReusableCellIdentifier? {
        
        return SectionHeaderView.reuseId
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.movies.isEmpty ? 0 : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return movies.count
        default:
            return person.facts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PersonInfoCell.reuseId,
                for: indexPath
            ) as? PersonInfoCell
            else {
                return UICollectionViewCell()
            }
            cell.hideSkeleton()
            cell.configure(with: person)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: KPItemCell.reuseId,
                for: indexPath
            ) as? KPItemCell else {
                return UICollectionViewCell()
            }
            cell.hideSkeleton()
            cell.configure(with: movies[indexPath.item])
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.reuseId,
                for: indexPath
            ) as? CategoryCell else {
                return UICollectionViewCell()
            }
            cell.hideSkeleton()
            cell.sectionKind = SectionKind.facts
            cell.configure(with: person.facts[indexPath.item].value)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //collectionView.reloadData()
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
            sectionHeaderView.title.text = ""
        case 1:
            sectionHeaderView.title.text = "Лучшие фильмы и сериалы"
        default:
            sectionHeaderView.title.text = "Знаете ли вы, что..."
        }
        
        return sectionHeaderView
    }
}

// MARK: - Networking
extension PersonDetailViewController {
    func setupPersonInfo(with person: Person) {
        self.person = person
        
        NetworkingManager.shared.fetchData(
            type: Movie.self,
            url: Links.moviesByPersonUrl.rawValue + "\(person.id)"
        ) { [weak self] result in
            switch result {
            case .success(let value):
                self?.movies = value
                self?.collectionView.stopSkeletonAnimation()
                self?.collectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                //self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
