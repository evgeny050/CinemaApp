//
//  PersonDescriptionCell.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 01.04.2024.
//

import UIKit
import Kingfisher
import SnapKit

final class PersonInfoCell: UICollectionViewCell, CellModelRepresanteble {
    // MARK: - Properties
    var viewModel: CellViewModelProtocol? {
        didSet {
            configure()
        }
    }
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private let personRUNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.isSkeletonable = true
        return label
    }()
    
    private let personENNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.isSkeletonable = true
        return label
    }()
    
    private let professionsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .lightGray
        label.isSkeletonable = true
        label.skeletonTextNumberOfLines = 3
        label.skeletonTextLineHeight = .relativeToFont
        return label
    }()
    
    private let moreInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подробнее", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        button.isSkeletonable = true
        button.isHidden = true
        return button
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        isSkeletonable = true
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Layout Of Cell
    private func commonInit() {
        let innerStackView = UIStackView(arrangedSubviews: [professionsLabel])
        innerStackView.axis = .vertical
        innerStackView.spacing = 2
        innerStackView.isSkeletonable = true
        
        let infoStackView = UIStackView(
            arrangedSubviews: [
                personRUNameLabel,
                personENNameLabel,
                innerStackView,
                moreInfoButton
            ]
        )
        infoStackView.axis = .vertical
        infoStackView.spacing = 12
        infoStackView.alignment = .fill
        infoStackView.isSkeletonable = true
        
        let mainStackView = UIStackView(arrangedSubviews: [avatarImageView, infoStackView])
        mainStackView.axis = .horizontal
        mainStackView.alignment = .top
        mainStackView.spacing = 10
        mainStackView.isSkeletonable = true
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.width.equalTo(130)
            make.height.equalTo(contentView)
        }
        
        layoutIfNeeded()
    }
    
    func configure() {
        guard let viewModel = viewModel as? CellViewModel else { return }
        guard let imageURL = URL(string: viewModel.imageUrl) else { return }
        avatarImageView.kf.indicatorType = .activity
        let processor = DownsamplingImageProcessor(size: avatarImageView.bounds.size)
        avatarImageView.kf.setImage(
            with: imageURL,
            options: [
                .processor(processor),
                .transition(.fade(1)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
        personRUNameLabel.text = viewModel.person?.name
        personENNameLabel.text = viewModel.person?.enName
        let string =
        """
        \(viewModel.person?.allProfs ?? "")
        \(viewModel.person?.birthRU ?? "")
        \(viewModel.person?.ageInRU ?? "")
        """
        let result = string.split(whereSeparator: \.isNewline).joined(separator: "\n")
        professionsLabel.text = result
    }
}

