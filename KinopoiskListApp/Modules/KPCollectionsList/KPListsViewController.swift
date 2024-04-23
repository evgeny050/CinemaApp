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
    var presenter: KPListsViewOutputProtocol!
    private var tableView: UITableView!
    private var sectionViewModel: SectionViewModelProtocol = SectionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        addSkeleton()
        presenter.viewDidLoad()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.register(KPListTableViewCell.self)
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.addSubview(tableView)
    }
    
    private func addSkeleton() {
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton()
    }
}

// MARK: - KPListsViewInputProtocol
extension KPListsViewController: KPListsViewInputProtocol {
    func reloadData(section: SectionViewModel) {
        title = section.categoryName
        sectionViewModel = section
        tableView.hideSkeleton(
            reloadDataAfter: true,
            transition: .crossDissolve(0.25)
        )
    }
}

// MARK: - SkeletonTableViewDataSource, SkeletonTableViewDelegate
extension KPListsViewController: SkeletonTableViewDataSource, SkeletonTableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionViewModel.numberOfKPListItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = sectionViewModel.kpListItems[indexPath.item]
        let cell = tableView.dequeueCell(cellType: KPListTableViewCell.self, for: indexPath)
        cell.labelRowId.text = indexPath.row.formatted()
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapCell(at: indexPath)
    }
    
    func collectionSkeletonView(
        _ skeletonView: UITableView,
        cellIdentifierForRowAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        return KPListTableViewCell.reuseId
    }
    
    func collectionSkeletonView(
        _ skeletonView: UITableView,
        prepareCellForSkeleton cell: UITableViewCell,
        at indexPath: IndexPath) {
        cell.isSkeletonable = true
    }
}
