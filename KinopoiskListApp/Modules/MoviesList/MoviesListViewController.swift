//
//  MoviesInCollectionViewController.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 01.04.2024.
//

import UIKit
import SkeletonView

final class MoviesListViewController: UIViewController {
    // MARK: - Properties
    private var sectionViewModel: SectionViewModelProtocol = SectionViewModel()
    var presenter: PresenterToViewMoviesListProtocol!
    private var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setupTableView()
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addSkeletonAnimation()
    }
    
    // MARK: - Adjust Height of Table HeaderView
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.updateHeaderViewHeight()
    }
}

// MARK: - ViewToPresenterMoviesListProtocol
extension MoviesListViewController: ViewToPresenterMoviesListProtocol {
    // MARK: - Set Table HeaderView
    func reloadHeader(with title: String) {
        let headerView = UIView()
        headerView.isSkeletonable = true
        
        let navTitleLabel = UILabel()
        navTitleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        navTitleLabel.sizeToFit()
        navTitleLabel.isSkeletonable = true
        navTitleLabel.skeletonCornerRadius = 3
        navTitleLabel.text = title
        navTitleLabel.numberOfLines = navTitleLabel.maxNumberOfLines
        
        headerView.addSubview(navTitleLabel)
        navTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        tableView.tableHeaderView = headerView
    }
    
    func reloadData(with section: SectionViewModel) {
        sectionViewModel = section
        tableView.stopSkeletonAnimation()
        tableView.hideSkeleton()
    }
}

// MARK: - Private Methodds
extension MoviesListViewController {
    // MARK: - Setup the SkeletonView
    private func addSkeletonAnimation() {
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton()
    }
    
    // MARK: - Setup the Table View
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.register(MovieTableViewCell.self)
        tableView.rowHeight = 140
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        view.addSubview(tableView)
    }
    
    private func showAlert(with error: Error? = nil) {
        let alert = UIAlertController(
            title: "Error server response",
            message: error?.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - SkeletonTableViewDataSource, SkeletonTableViewDelegate
extension MoviesListViewController: SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionViewModel.numberOfMovieItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieTableViewCell.reuseId,
            for: indexPath
        ) as? MovieTableViewCell else { return UITableViewCell() }
        cell.viewModel = sectionViewModel.movieItems[indexPath.item]
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return MovieTableViewCell.reuseId
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, 
        prepareCellForSkeleton cell: UITableViewCell,
            at indexPath: IndexPath) {
        cell.isSkeletonable = true
    }
}
