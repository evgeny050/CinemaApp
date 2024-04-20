//
//  ViewController.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 13.03.2024.
//

import UIKit
import AlamofireImage
import SkeletonView

final class HomeInfoViewController: UIViewController {
    // MARK: - Properties
    var presenter: HomeInfoViewOutputProtocol!
    
    //UICV Properties
    private var collectionView: UICollectionView!
    private var sectionViewModel: SectionViewModelProtocol = SectionViewModel()
    private let sectionHeaderView = SectionHeaderView()
    
    //SearchBar Properties
    private var searchController: UISearchController!
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSearchController()
        setupCollectionView()
        addSkeletonAnimation()
        presenter.viewDidLoad()
    }
}

// MARK: - Extensions - HomeInfoViewInputProtocol
extension HomeInfoViewController: HomeInfoViewInputProtocol {
    func reloadData(section: SectionViewModel) {
        sectionViewModel = section
        collectionView.stopSkeletonAnimation()
        collectionView.hideSkeleton(
            reloadDataAfter: true,
            transition: .crossDissolve(0.25)
        )
    }
}

// MARK: - Extensions - Private Methodds
extension HomeInfoViewController {
    // MARK: - Setup the Collection View
    private func setupCollectionView() {
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: createCompositionalLayout()
        )
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(KPListCollectionViewCell.self)
        collectionView.register(KPItemCell.self)
        collectionView.register(CategoryCell.self)
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseId
        )
        
        view.addSubview(collectionView)
    }
    
    // MARK: - Setup the Search Controller and Scope Bar
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.definesPresentationContext = true
        searchController.searchBar.placeholder = "Фильмы, персоны, сериалы"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.scopeButtonTitles = [
            "Все результаты",
            "Онлайн-кинотеатр"
        ]
        searchController.searchBar.delegate = self
    }
    
    // MARK: - Setup the Navigation Bar
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Setup the SkeletonView
    private func addSkeletonAnimation() {
        SkeletonAppearance.default.skeletonCornerRadius = 4
        collectionView.isSkeletonable = true
        collectionView.showAnimatedGradientSkeleton()
    }
}

// MARK: - Extensions - Setup UICVCompositionalLayout
extension HomeInfoViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment)
            -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return CellFactory.createSection(for: .collections)
            case 1:
                return CellFactory.createSection(for: .categories)
            default:
                return CellFactory.createSection(for: .collections)
            }
        }
        return layout
    }
}

// MARK: - Extensions - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeInfoViewController: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate {
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        prepareCellForSkeleton cell: UICollectionViewCell,
        at indexPath: IndexPath
    ) {
        cell.isSkeletonable = true
    }
    
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> SkeletonView.ReusableCellIdentifier {
        switch indexPath.section {
        case 0:
            return KPListCollectionViewCell.reuseId
        case 1:
            return CategoryCell.reuseId
        default:
            return KPItemCell.reuseId
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
            return sectionViewModel.numberOfKPListItems
        case 1:
            return sectionViewModel.numberOfCategoryItems
        default:
            return sectionViewModel.numberOfPersonItems
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cellViewModel = sectionViewModel.kpListItems[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "KPListCollectionViewCell",//cellViewModel.reuseId,
                for: indexPath
            ) as? KPListCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.hideSkeleton()
            cell.viewModel = cellViewModel
            return cell
        case 1:
            let cellViewModel = sectionViewModel.categoryItems[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CategoryCell",//CategoryCell.reuseId,
                for: indexPath
            ) as? CategoryCell else {
                return UICollectionViewCell()
            }
            cell.hideSkeleton()
            cell.viewModel = cellViewModel
            return cell
        default:
            let cellViewModel = sectionViewModel.personItems[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "KPItemCell",//cellViewModel.reuseId,
                for: indexPath
            ) as? KPItemCell else {
                return UICollectionViewCell()
            }
            cell.hideSkeleton()
            cell.viewModel = cellViewModel
            return cell
        }
    }
        
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            presenter.didTapCell(at: indexPath)
        case 1:
            presenter.didTapCell(at: indexPath)
        default:
            presenter.didTapCell(at: indexPath)
        }
    }
}


// MARK: - Extensions - UISearchBarDelegate, UISearchResultsUpdating
extension HomeInfoViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("scope selection started")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("search started")
    }
}
