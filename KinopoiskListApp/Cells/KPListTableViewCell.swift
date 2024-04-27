//
//  KPListTableViewCell.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 12.04.2024.
//

import UIKit
import Kingfisher
import SnapKit

final class KPListTableViewCell: UITableViewCell, CellModelRepresanteble {
    // MARK: - Properties
    var viewModel: CellViewModelProtocol? {
        didSet {
            configure()
        }
    }
    
    private let kpListImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isSkeletonable = true
        //imageView.backgroundColor = .blue
        return imageView
    }()
    
    private let kpListNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.isSkeletonable = true
        label.skeletonTextNumberOfLines = 3
        //label.backgroundColor = .green
        return label
    }()
    
    let labelRowId: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        label.textAlignment = .left
        label.isSkeletonable = true
        //label.backgroundColor = .green
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.isSkeletonable = true
        return stackView
    }()
    
    // MARK: - Setup Layout
    private func setupLayout() {
        //stackView.backgroundColor = .orange
        stackView.addArrangedSubview(labelRowId)
        stackView.addArrangedSubview(kpListImageView)
        stackView.addArrangedSubview(kpListNameLabel)
        
        labelRowId.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-15)
            make.width.equalTo(15)
        }
        
        kpListImageView.snp.makeConstraints { make in
            make.width.equalTo(kpListImageView.snp.height)
        }
        
        kpListNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
                .inset(UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
        }
    }
    
    private func configure() {
        guard let viewModel = viewModel as? CellViewModel else { return }
        guard let imageURL = URL(string: viewModel.imageUrl) else { return }
        kpListImageView.kf.indicatorType = .activity
        kpListImageView.kf.setImage(
            with: imageURL,
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
        kpListNameLabel.text = viewModel.cellItemName
        setupLayout()
    }
}
