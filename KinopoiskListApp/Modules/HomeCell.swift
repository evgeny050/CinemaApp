//
//  HomeCell.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 20.03.2024.
//

import UIKit
import Kingfisher
import SnapKit

class HomeCell: UICollectionViewCell {
    static let reuseId = "HomeCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: Font.helveticaBold.rawValue, size: 13)
        label.sizeToFit()
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    // MARK: - Setup layout of cell
    private func commonInit() {
        addSubview(stackView)
        stackView.addArrangedSubview(movieImageView)
        stackView.addArrangedSubview(movieNameLabel)
        
        // Setup constraints
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.bottom.lessThanOrEqualTo(0)
            make.right.equalTo(self)
        }
        
        movieImageView.snp.makeConstraints { make in
            make.height.equalTo(125)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with collection: KPCollection) {
        guard let imageURL = URL(string: collection.cover.url) else { return }
        movieImageView.kf.indicatorType = .activity
        movieImageView.kf.setImage(
            with: imageURL,
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
        movieNameLabel.text = collection.name
    }
}
