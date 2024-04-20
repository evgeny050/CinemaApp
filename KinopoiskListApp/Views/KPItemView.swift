//
//  KPItemView.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 17.04.2024.
//

import UIKit
import SnapKit

class KPItemView: UIView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stackView = UIStackView()
        stackView.distribution = .fill
        //stackView.distribution  = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubview(kpItemImageView)
        stackView.addArrangedSubview(kpItemNameLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        kpItemImageView.snp.makeConstraints { make in
            make.height.equalTo(180)//.priority(.medium)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
