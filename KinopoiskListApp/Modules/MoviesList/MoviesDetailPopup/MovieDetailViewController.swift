//
//  MovieDetailViewController.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 22.04.2024.
//

import UIKit
import SnapKit
import Kingfisher

class MovieDetailViewController: UITableViewController {
    
    // MARK: - Properties
    var viewModel: CellViewModelProtocol = CellViewModel() {
        didSet {
            updateView()
        }
    }
    
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let ruNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        label.backgroundColor = .green
        return label
    }()
    
    private let periodLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.backgroundColor = .yellow
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieImageView, infoStackView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.backgroundColor = .red
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ruNameLabel, periodLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = .orange
        customizeView()
    }
    
    // MARK: - Adjust Height of Table HeaderView
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //tableView.updateHeaderViewHeight()
    }
    
    private func customizeView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.sectionHeaderTopPadding = 10
        tableView.sectionHeaderHeight = 80
        
        movieImageView.snp.makeConstraints { make in
            make.width.equalTo(55)
        }
    }
    
    private func updateView() {
        let imageURL  = URL(string: viewModel.imageUrl)
        let processor = DownsamplingImageProcessor(size: CGSize(width: 55, height: 80))
        movieImageView.kf.indicatorType = .activity
        movieImageView.kf.setImage(
            with: imageURL,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        { [weak self] result in
            switch result {
            case .success(_):
                self?.tableView.reloadData()
            case .failure(_):
                break
            }
        }
        
        ruNameLabel.text = viewModel.cellItemName
        periodLabel.text = "2020"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell") else { return UITableViewCell() }
        
        var content = cell.defaultContentConfiguration()
        content.text = (index == 0) ? "Буду смотреть" : "Просмотрен"
        content.image = UIImage(systemName: (index == 0) ? "bookmark": "eye")
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return mainStackView
    }
}
