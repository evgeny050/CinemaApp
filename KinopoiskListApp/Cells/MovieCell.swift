//
//  MovieCell.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 01.04.2024.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let reuseId = "MovieCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .green
        return imageView
    }()
    
    private let movieRUNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        //label.sizeToFit()
        //label.backgroundColor = .orange
        return label
    }()
    
    private let movieENNameAndPeriodLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        //label.sizeToFit()
        //label.backgroundColor = .orange
        return label
    }()
    
    private let countryAndGenreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .lightGray
        //label.sizeToFit()
        //label.backgroundColor = .orange
        return label
    }()
    
    private let watchOnlineButton: UIButton = {
        let button = UIButton()
        button.imageView?.image = UIImage(systemName: "play.fill")
        button.setTitle("Смотреть", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.tintColor = .orange
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
        button.isHidden = true
        return button
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
    
    // MARK: - Setup layout
    private func commonInit() {
        let innerStackView = UIStackView(arrangedSubviews: [movieRUNameLabel, movieENNameAndPeriodLabel, countryAndGenreLabel])
        innerStackView.axis = .vertical
        innerStackView.distribution = .fill
        innerStackView.alignment = .leading
        innerStackView.spacing = 5
        
        let infoStackView = UIStackView(arrangedSubviews: [innerStackView, watchOnlineButton])
        infoStackView.axis = .vertical
        infoStackView.distribution = .fill
        infoStackView.alignment = .leading
        infoStackView.spacing = 20
        
        let mainStackView = UIStackView(arrangedSubviews: [movieImageView, infoStackView])
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func configure(with movie: Movie) {
        
    }
}
