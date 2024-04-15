//
//  MoviesInCollectionViewController.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 01.04.2024.
//

import UIKit
import SkeletonView

final class MoviesByKPListViewController: UIViewController {
    
    //MARK: - Properties
    private var tableView: UITableView!
    
    private lazy var navTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.sizeToFit()
        label.isSkeletonable = true
        label.skeletonCornerRadius = 3
        return label
    }()
    
    private var movies: [Movie] = []

    // MARK: - Overrided Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addSkeletonAnimation()
    }
    
    //Adjust Height of Table View Header
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.updateHeaderViewHeight()
    }
}

// MARK: - Private Methodds
extension MoviesByKPListViewController {
    // MARK: - Setup the SkeletonView
    private func addSkeletonAnimation() {
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton()
    }
    
    // MARK: - Setup the Table View
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseId)
        tableView.rowHeight = 140
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        
        // Set Header For Table View
        let headerView = UIView()
        headerView.isSkeletonable = true
        navTitleLabel.numberOfLines = navTitleLabel.maxNumberOfLines
        headerView.addSubview(navTitleLabel)
        navTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        tableView.tableHeaderView = headerView
        
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
extension MoviesByKPListViewController: SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieTableViewCell.reuseId,
            for: indexPath
        ) as? MovieTableViewCell else { return UITableViewCell() }
        cell.configure(with: movies[indexPath.item])
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
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieTableViewCell.reuseId
        ) as? MovieTableViewCell
        cell?.movieImageView.kf.cancelDownloadTask()
    }
}

// MARK: - Networking
extension MoviesByKPListViewController {
    func fetchMovies(from kpList: KPList) {
        navTitleLabel.text = kpList.name
        NetworkingManager.shared.fetchDataFaster(
            type: KPMovieSection.self,
            url: Links.moviesByKPListUrl.rawValue,
            parameters: [
                "notNullFields": ["poster.url"],
                "lists" : [kpList.slug]
            ]
            
        ) { [weak self] result in
            switch result {
            case .success(let value):
                self?.movies = value.docs
                self?.tableView.stopSkeletonAnimation()
                self?.tableView.hideSkeleton(
                    reloadDataAfter: true,
                    transition: .crossDissolve(0.25)
                )
            case .failure(let error):
                print(error)
                self?.showAlert(with: error)
            }
        }
    }
}
