//
//  PersonCell.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 28.03.2024.
//

import UIKit
import Kingfisher
import SnapKit

class PersonCell: UICollectionViewCell {
    static let reuseId = "PersonCell"
    
    private let personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .green
        return imageView
    }()
    
    private let personNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubview(stackView)
        stackView.addArrangedSubview(personImageView)
        stackView.addArrangedSubview(personNameLabel)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        personImageView.snp.makeConstraints { make in
            make.height.equalTo(180)
        }
    }
    
    func configure(with person: Person) {
        guard let imageURL = URL(string: person.photo) else { return }
        personImageView.kf.indicatorType = .activity
        personImageView.kf.setImage(
            with: imageURL,
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
        personNameLabel.text = person.name
    }
    
    func configure(with movie: Movie) {
        guard let imageURL = URL(string: movie.poster.url) else { return }
        personImageView.kf.indicatorType = .activity
        personImageView.kf.setImage(
            with: imageURL,
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
        personNameLabel.text = movie.name
    }
}

