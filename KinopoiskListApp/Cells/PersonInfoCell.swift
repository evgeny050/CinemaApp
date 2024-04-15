//
//  PersonDescriptionCell.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 01.04.2024.
//

import UIKit
import Kingfisher
import SnapKit

class PersonInfoCell: UICollectionViewCell {
    // MARK: - Properties
    static let reuseId = "PersonInfoCell"
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private let personRUNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Default Ru Name"
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.isSkeletonable = true
        return label
    }()
    
    private let personENNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Default en name"
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.isSkeletonable = true
        return label
    }()
    
    private let professionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Default professions"
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .lightGray
        label.isSkeletonable = true
        return label
    }()
    
    private let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Default birthday"
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .lightGray
        label.isSkeletonable = true
        return label
    }()
    
    private let ageAndGrowthLabel: UILabel = {
        let label = UILabel()
        label.text = "Default age and growth"
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .lightGray
        label.isSkeletonable = true
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
        self.isSkeletonable = true
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Layout Of Cell
    private func commonInit() {
        let innerStackView = UIStackView(arrangedSubviews: [professionsLabel, birthdayLabel, ageAndGrowthLabel])
        innerStackView.axis = .vertical
        innerStackView.distribution = .fill
        innerStackView.alignment = .leading
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
        infoStackView.distribution = .fill
        infoStackView.alignment = .leading
        infoStackView.spacing = 12
        infoStackView.isSkeletonable = true
        
        let mainStackView = UIStackView(arrangedSubviews: [avatarImageView, infoStackView])
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fill
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
    }
    
    // MARK: - Configure UI Data
    func configure(with person: Person) {
        guard let imageURL = URL(string: person.photo) else { return }
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
        {
            result in
            switch result {
            case .success(_):
                //print("Task done for: \(value.source.url?.absoluteString ?? "")")
                break
            case .failure(let error):
                //print("Job failed: \(error.localizedDescription)")
                break
            }
        }
        personRUNameLabel.text = person.name
        personENNameLabel.text = person.enName
        
        let profs = person.profession.map { prof in
            return prof.value
        }
        professionsLabel.text = profs.joined(separator: " ")
        
        birthdayLabel.text = person.birthdayInFormat
        ageAndGrowthLabel.text = person.age.formatted()
    }
}

