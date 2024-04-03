//
//  SearchCell.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 28.03.2024.
//

import UIKit
import Kingfisher
import SnapKit

class SearchCell: UICollectionViewCell {
    static let reuseId = "SearchCell"
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        //imageView.clipsToBounds = true
        imageView.backgroundColor = .green
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        //label.sizeToFit()
        label.backgroundColor = .orange
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
    
    var sectionKind: SectionKind?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        itemImageView.clipsToBounds = sectionKind?.isClipped ?? false
        addSubview(stackView)
        stackView.addArrangedSubview(itemImageView)
        stackView.addArrangedSubview(nameLabel)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.bottom.lessThanOrEqualTo(0)
            make.right.equalTo(self)
        }
        
        itemImageView.snp.makeConstraints { make in
            make.height.equalTo(sectionKind?.imageHeight ?? 125)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(50)
        }
    }
    
    func configure<T>(with item: T) {
        if let collection = item as? KPCollection {
            guard let imageURL = URL(string: collection.cover.url) else { return }
            getImageByKF(with: imageURL)
            nameLabel.text = collection.name
        } else if let person = item as? Person {
            guard let imageURL = URL(string: person.photo) else { return }
            getImageByKF(with: imageURL)
            nameLabel.text = person.name
            if person.name.contains("Флора") {
                print(itemImageView.bounds.size.height)
            }
        }
    }
    
    func getImageByKF(with imageURL: URL) {
        itemImageView.kf.indicatorType = .activity
        itemImageView.kf.setImage(
            with: imageURL,
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }
}

