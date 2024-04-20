//
//  PersonCell.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 28.03.2024.
//

import UIKit
import Kingfisher
import SnapKit

final class KPItemCell: UICollectionViewCell, CellModelRepresanteble {
    // MARK: - Properties
    var viewModel: CellViewModelProtocol? {
        didSet {
            updateView()
        }
    }
    
    private let kpItemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let kpItemNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.sizeToFit()
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Layout
    private func commonInit() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        //stackView.distribution  = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 8
        
        stackView.addArrangedSubview(kpItemImageView)
        stackView.addArrangedSubview(kpItemNameLabel)
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        kpItemImageView.snp.makeConstraints { make in
            make.height.equalTo(180).priority(.medium)
        }
    }
    
    private func updateView() {
        guard let viewModel = viewModel as? CellViewModel else { return }
        guard let imageURL = URL(string: viewModel.imageUrl) else { return }
        let processor = DownsamplingImageProcessor(size: kpItemImageView.bounds.size)
        kpItemImageView.kf.indicatorType = .activity
        kpItemImageView.kf.setImage(
            with: imageURL,
            options: [
                .processor(processor),
                .transition(.fade(1)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
        kpItemNameLabel.text = viewModel.cellItemName
    }
}

