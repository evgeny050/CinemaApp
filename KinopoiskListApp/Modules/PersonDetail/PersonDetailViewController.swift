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
    var presenter: PresenterToViewPersonDetailProtocol!
    
    private var collectionView: UICollectionView!
    private let sectionHeaderView = SectionHeaderView()
    private var sectionViewModel: SectionViewModelProtocol = SectionViewModel()
    private lazy var cellViewModel: CellViewModelProtocol = CellViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setupCollectionView()
        showSkeletonAnimation()
        presenter.viewDidLoad()
    }
    
    // MARK: - Skeleton View
    private func showSkeletonAnimation() {
        collectionView.isSkeletonable = true
        collectionView.showAnimatedGradientSkeleton()
    }
    
    // MARK: - Setup the Collection View
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PersonInfoCell.self)
        collectionView.register(KPItemCell.self)
        collectionView.register(CategoryCell.self)

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
                return CellFactory.createSection(for: .personInfo)
            case 1:
                return CellFactory.createSection(for: .movies)
            default:
                return CellFactory.createSection(for: .facts)
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
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
    
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        supplementaryViewIdentifierOfKind: String,
        at indexPath: IndexPath
    ) -> ReusableCellIdentifier? {
        return SectionHeaderView.reuseId
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return sectionViewModel.numberOfMovieItems
        default:
            return sectionViewModel.numberOfCategoryItems
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cellViewModel = sectionViewModel.singlePerson
            let cell = collectionView.dequeueCell(cellType: PersonInfoCell.self, for: indexPath)
            cell.hideSkeleton()
            cell.viewModel = cellViewModel
            return cell
        case 1:
            let cellViewModel = sectionViewModel.movieItems[indexPath.item]
            let cell = collectionView.dequeueCell(cellType: KPItemCell.self, for: indexPath)
            cell.hideSkeleton()
            cell.viewModel = cellViewModel
            return cell
        default:
            let cellViewModel = sectionViewModel.categoryItems[indexPath.item]
            let cell = collectionView.dequeueCell(cellType: CategoryCell.self, for: indexPath)
            cell.hideSkeleton()
            cell.viewModel = cellViewModel
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            presenter.didTapCell(at: indexPath)
        }
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

// MARK: - Extensions - ViewToPresenterPersonDetailProtocol
extension PersonDetailViewController: ViewToPresenterPersonDetailProtocol {
    func reloadData(with section: SectionViewModel) {
        sectionViewModel = section
        cellViewModel = section.singlePerson
        collectionView.hideSkeleton(
            reloadDataAfter: true,
            transition: .crossDissolve(0.25)
        )
    }
}
