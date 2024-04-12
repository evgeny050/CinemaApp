//
//  MoviesTableViewController.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 04.04.2024.
//

import UIKit
import SkeletonView

class MoviesTableViewController: UITableViewController {

    // MARK: - Properties
    var kpCollection: KPList!
    private lazy var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.showAnimatedGradientSkeleton()
        setupTableView()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton()
//        tableView.showAnimatedGradientSkeleton(
//            usingGradient: SkeletonGradient(baseColor: .link),
//            animation: nil,
//            transition: .crossDissolve(0.25)
//        )
    }
    
    // MARK: - Setup the Table View
    private func setupTableView() {
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseId)
        tableView.rowHeight = 140
        tableView.tableHeaderView = UIView()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return MovieTableViewCell.reuseId
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieTableViewCell.reuseId,
            for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: movies[indexPath.item])
        cell.isSkeletonable = true
        cell.contentView.isSkeletonable = true
        cell.movieImageView.isSkeletonable = true
        return cell
    }
}

// MARK: - Networking
extension MoviesTableViewController {
    func fetchMovies(from kpCollection: KPList) {
        self.kpCollection = kpCollection
        NetworkingManager.shared.fetchData(
            type: Movie.self,
            url: Links.moviesByCollectionUrl.rawValue + kpCollection.slug
        ) { [weak self] result in
            switch result {
            case .success(let value):
                self?.movies = value
                //self?.tableView.stopSkeletonAnimation()
                //self?.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
