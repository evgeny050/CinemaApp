//
//  HomeCell.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 20.03.2024.
//

import UIKit
import Kingfisher
import SnapKit

class KPCollectionCell: UICollectionViewCell {
    static let reuseId = "KPCollectionCell"
    
    private let collectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        //imageView.clipsToBounds = true
        imageView.backgroundColor = .green
        return imageView
    }()
    
    private let collectionNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        label.sizeToFit()
        label.backgroundColor = .orange
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 8
        stack.backgroundColor = .green
        return stack
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Layout
    private func commonInit() {
        addSubview(stackView)
        stackView.addArrangedSubview(collectionImageView)
        stackView.addArrangedSubview(collectionNameLabel)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        collectionImageView.snp.makeConstraints { make in
            make.height.equalTo(125)
        }
    }
    
    // MARK: - Configure with model object
    func configure(with collection: KPCollection) {
        guard let imageURL = URL(string: collection.cover.url) else { return }
        collectionImageView.kf.indicatorType = .activity
        collectionImageView.kf.setImage(
            with: imageURL,
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
        collectionNameLabel.text = collection.name
    }
    
    func configure(with movie: Movie) {
        guard let imageURL = URL(string: movie.poster.url) else { return }
        collectionImageView.kf.indicatorType = .activity
        collectionImageView.kf.setImage(
            with: imageURL,
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
        collectionNameLabel.text = movie.name
    }
    
}
