//
//  PersonCell.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 28.03.2024.
//

import UIKit
import Kingfisher
import SnapKit

final class KPItemCell: UICollectionViewCell {
    // MARK: - Properties
    static let reuseId = "KPItemCell"
    
    private lazy var kpItemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        imageView.skeletonCornerRadius = 0
        return imageView
    }()
    
    private let personNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.sizeToFit()
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSkeletonable = true
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
        stackView.axis = .vertical
        stackView.spacing = 8
        
        stackView.addArrangedSubview(kpItemImageView)
        stackView.addArrangedSubview(personNameLabel)
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        kpItemImageView.snp.makeConstraints { make in
            make.height.equalTo(180)
        }
    }
    
    func configure(with person: Person) {
        guard let imageURL = URL(string: person.photo) else { return }
        let processor = DownsamplingImageProcessor(size: kpItemImageView.bounds.size)
        kpItemImageView.kf.setImage(
            with: imageURL,
            options: [
                .processor(processor),
                .transition(.fade(1)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
        { [unowned self]
            result in
            switch result {
            case .success(_):
                kpItemImageView.hideSkeleton()
                //print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        personNameLabel.text = person.name
    }
    
    func configure(with movie: Movie) {
        kpItemImageView.showSkeleton()
        guard let imageURL = URL(string: movie.poster.url) else { return }
        let processor = DownsamplingImageProcessor(size: kpItemImageView.bounds.size)
        kpItemImageView.kf.setImage(
            with: imageURL,
            options: [
                .processor(processor),
                .transition(.fade(1)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
        { [unowned self]
            result in
            switch result {
            case .success(_):
                kpItemImageView.hideSkeleton()
                //print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        personNameLabel.text = movie.name
    }
}

