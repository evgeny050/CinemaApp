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
    static let reuseId = "PersonInfoCell"
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .brown
        return imageView
    }()
    
    private let personRUNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        //label.sizeToFit()
        //label.backgroundColor = .orange
        return label
    }()
    
    private let personENNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        //label.sizeToFit()
        //label.backgroundColor = .systemPink
        return label
    }()
    
    private let professionsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .lightGray
        //label.sizeToFit()
        //label.backgroundColor = .red
        return label
    }()
    
    private let birthdayLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .lightGray
        //label.sizeToFit()
        //label.backgroundColor = .yellow
        return label
    }()
    
    private let ageAndGrowthLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .lightGray
        //label.sizeToFit()
        //label.backgroundColor = .gray
        return label
    }()
    
    private let moreInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подробнее", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        //button.backgroundColor = .green
        return button
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .red
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
        innerStackView.spacing = 5
        
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
        infoStackView.spacing = 15
        
        let mainStackView = UIStackView(arrangedSubviews: [avatarImageView, infoStackView])
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fillProportionally
        mainStackView.spacing = 10
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.width.equalTo(130)//0.3 * self.frame.width)
        }
        
    }
    
    func configure(with person: Person) {
        guard let imageURL = URL(string: person.photo) else { return }
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(
            with: imageURL,
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
        personRUNameLabel.text = person.fullName
        personENNameLabel.text = person.enName
        
        let profs = person.profession.map { prof in
            return prof.value
        }
        professionsLabel.text = profs.joined(separator: " ")
        
        birthdayLabel.text = person.birthdayInFormat
        ageAndGrowthLabel.text = person.age.formatted()
    }
}

