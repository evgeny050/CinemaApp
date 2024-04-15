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
    
    func configure(with person: Person) {
        guard let imageURL = URL(string: person.photo) else { return }
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
        { //[unowned self]
            result in
            switch result {
            case .success(_):
                break
                //kpItemImageView.hideSkeleton()
                //print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                let person = person
                //break
                print("Job failed for \(person.name) \(error)")
            }
        }
        kpItemNameLabel.text = person.name
    }
    
    func configure(with movie: Movie) {
        guard let imageURL = URL(string: movie.poster.url) else { return }
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
        { //[unowned self]
            result in
            switch result {
            case .success(_):
                break
                //kpItemImageView.hideSkeleton()
                //print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(_):
                //let movie = movie
                break
                //print("Job failed: \(error.localizedDescription)")
            }
        }
        kpItemNameLabel.text = movie.name
    }
}

