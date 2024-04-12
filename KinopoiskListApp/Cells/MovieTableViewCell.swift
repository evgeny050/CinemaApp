//
//  MovieTableViewCell.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 04.04.2024.
//

import UIKit
import Kingfisher
import SkeletonView

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseId = "MovieTableViewCell"

    //private let imageCache = NSCache<AnyObject, UIImage>()
    
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        imageView.skeletonCornerRadius = 5
        return imageView
    }()
    
    private let rUNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        label.isSkeletonable = true
        label.skeletonCornerRadius = 3
        label.skeletonTextLineHeight = .relativeToFont
        return label
    }()
    
    private let enNameAndPeriodLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.isSkeletonable = true
        label.skeletonCornerRadius = 3
        label.skeletonTextLineHeight = .relativeToFont
        return label
    }()
    
    private let countryAndGenreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .lightGray
        label.isSkeletonable = true
        label.skeletonCornerRadius = 3
        label.skeletonTextLineHeight = .relativeToFont
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

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Layout
    private func commonInit() {
        let innerStackView = UIStackView(arrangedSubviews: [rUNameLabel, enNameAndPeriodLabel, countryAndGenreLabel])
        innerStackView.axis = .vertical
        innerStackView.distribution = .fill
        innerStackView.alignment = .fill
        innerStackView.spacing = 5
        innerStackView.isSkeletonable = true
        
        let emptyView = UIView()
        
        let infoStackView = UIStackView(arrangedSubviews: [innerStackView, emptyView, watchOnlineButton])
        infoStackView.axis = .vertical
        infoStackView.distribution = .fill
        infoStackView.alignment = .fill
        infoStackView.spacing = 12
        infoStackView.isSkeletonable = true
        
        let mainStackView = UIStackView(arrangedSubviews: [movieImageView, infoStackView])
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        mainStackView.isSkeletonable = true
        
        contentView.addSubview(mainStackView)
        
        // Setup Constraints
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-10)
        }
        
        movieImageView.snp.makeConstraints { make in
            make.width.equalTo(80)//0.3 * self.frame.width)
        }
    
    }
    
    func configure(with movie: Movie/*, completion: @escaping(String) -> UITableViewCell*/) {
//        let concurrentQueue = DispatchQueue(label: "ru.denisegaluev.concurrent-queue", attributes: .concurrent)
//
//        // Помечаем асинхронный вызов флагом .barrier
//        concurrentQueue.async(flags: .barrier) {
//            // ...
//        }
        movieImageView.showSkeleton()
        guard let imageURL = URL(string: movie.poster.url) else { return }
        //movieImageView.kf.indicatorType = .activity
        
//        let workItem = DispatchWorkItem { [unowned self] in
//            movieImageView.kf.setImage(
//                with: imageURL,
//                options: [
//                    .transition(.fade(1)),
//                    .cacheOriginalImage
//                ])
//        }
//        DispatchQueue(label: "ru.iakovlev.serial-queue").async(execute: workItem)
        
//        if let cachedImage =  self.imageCache.object(forKey: imageURL.lastPathComponent as AnyObject) {
//            self.movieImageView.image = cachedImage
//            debugPrint("image from cache")
//        }
        
        let processor = DownsamplingImageProcessor(size: CGSize(width: 80, height: self.bounds.height))
        movieImageView.kf.setImage(
            with: imageURL,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        { [unowned self]
            result in
            switch result {
            case .success(_):
                movieImageView.hideSkeleton()
                //break
                //completion("Image loaded succesfullly")
                //print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                break
                //print(error)
                //completion("Image loading failed")
                //print("Job failed: \(error.localizedDescription)")
            }
//            rUNameLabel.text = movie.name
//            enNameAndPeriodLabel.text = "\(movie.enName ?? ""), \(movie.year)"
//            let countries = movie.countries.map { country in
//                return country.name
//            }
//            let genres = movie.genres.map { genre in
//                return genre.name
//            }
//            countryAndGenreLabel.text = "\(countries.joined(separator: " ")) - \(genres.joined(separator: " "))"
        }
        
//        workItem.notify(queue: DispatchQueue.main) { [unowned self] in
//            rUNameLabel.text = movie.name
//            enNameAndPeriodLabel.text = "\(movie.enName ?? ""), \(movie.year)"
//            let countries = movie.countries.map { country in
//                return country.name
//            }
//            let genres = movie.genres.map { genre in
//                return genre.name
//            }
//            countryAndGenreLabel.text = "\(countries.joined(separator: " ")) - \(genres.joined(separator: " "))"
//        }
        
        rUNameLabel.text = movie.name
        enNameAndPeriodLabel.text = "\(movie.year)"
        let countries = movie.countries.map { country in
            return country.name
        }
        let genres = movie.genres.map { genre in
            return genre.name
        }
        countryAndGenreLabel.text = "\(countries.joined(separator: " ")) - \(genres.joined(separator: " "))"
    }
    
}
