//
//  MoviesInCollectionViewController.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 01.04.2024.
//

import UIKit

class MoviesInCollectionViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width, height: 120)
        //layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //collectionView.collectionViewLayout = layout
        //collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
        return collectionView
    }()
    
    var kpCollection: KPCollection!
    private lazy var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MoviesInCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCell.reuseId,
            for: indexPath) as? MovieCell else { return UICollectionViewCell() }
        cell.configure(with: movies[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MoviesInCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.size.width, height: 120)
    }
}

// MARK: - Networking
extension MoviesInCollectionViewController {
    func fetchMovies(from kpCollection: KPCollection) {
        self.kpCollection = kpCollection
        NetworkingManager.shared.fetchData(
            type: Movie.self,
            url: Links.moviesByCollectionUrl.rawValue + kpCollection.slug
        ) { [unowned self] result in
            switch result {
            case .success(let value):
                movies = value
            case .failure(let error):
                print(error)
            }
        }
    }
}
