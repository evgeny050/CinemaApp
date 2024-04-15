//
//  KPListsViewController.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 12.04.2024.
//

import UIKit
import SkeletonView

final class KPListsViewController: UIViewController {
    // MARK: - Properties
    private var tableView: UITableView!
    private var kpLists: [KPList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        showSkeletonAnimation()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.register(KPListTableViewCell.self, forCellReuseIdentifier: KPListTableViewCell.reuseId)
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.addSubview(tableView)
    }
    
    private func showSkeletonAnimation() {
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton()
    }
}

// MARK: - SkeletonTableViewDataSource, SkeletonTableViewDelegate
extension KPListsViewController: SkeletonTableViewDataSource, SkeletonTableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kpLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: KPListTableViewCell.reuseId,
            for: indexPath) as? KPListTableViewCell else { return UITableViewCell() }
        cell.labelRowId.text = indexPath.row.formatted()
        cell.configure(with: kpLists[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MoviesByKPListViewController()
        vc.fetchMovies(from: kpLists[indexPath.item])
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return KPListTableViewCell.reuseId
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, 
                                prepareCellForSkeleton cell: UITableViewCell,
                                at indexPath: IndexPath) {
        cell.isSkeletonable = true
    }
}

// MARK: - Networking
extension KPListsViewController {
    func fetchKPListsByCategory(with category: String) {
        self.title = category
        NetworkingManager.shared.fetchData(
            type: KPList.self,
            url: Links.kpListsByCategoryUrl.rawValue,
            parameters: [
                "notNullFields": ["cover.url"],
                "category": category
            ]
            
        ) { [weak self] result in
            switch result {
            case .success(let value):
                self?.kpLists = value
                self?.tableView.stopSkeletonAnimation()
                self?.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            case .failure(let error):
                print(error)
            }
        }
    }
}
