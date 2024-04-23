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
    private var lastYScrollOffset: CGFloat = 0
    
    private lazy var navTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.sizeToFit()
        label.isSkeletonable = true
        label.skeletonCornerRadius = 3
        label.numberOfLines = label.maxNumberOfLines
        print(label.text ?? "")
        return label
    }()
    
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
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}

// MARK: - ViewToPresenterMoviesListProtocol
extension MoviesListViewController: ViewToPresenterMoviesListProtocol {
    // MARK: - Set Table HeaderView
    func reloadHeader(with title: String) {
        navTitleLabel.text = title

        let headerView = UIView()
        headerView.isSkeletonable = true
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

// MARK: - UIScrollViewDelegate
extension MoviesListViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //static var lastY: CGFloat = 0
        let currentY = scrollView.contentOffset.y
        let headerHeight = tableView.tableHeaderView?.bounds.height ?? 0
        
        // header disappears
        if (lastYScrollOffset <= headerHeight) && (currentY > headerHeight) {
            title = navTitleLabel.text
        }
        
        // header appears
        if (lastYScrollOffset > headerHeight) && (currentY <= headerHeight) {
            title = ""
        }
        
        lastYScrollOffset = currentY
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.viewModel = sectionViewModel.movieItems[indexPath.row]
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        present(vc, animated: true)
    }
}
