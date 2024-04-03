//
//  CategoriesCell.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 26.03.2024.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let reuseId = "CategoryCell"
    
    var sectionKind = SectionKind.categories
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func customizeView() {
        backgroundColor = #colorLiteral(red: 0.9205616117, green: 0.9205616117, blue: 0.9205616117, alpha: 1)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        addSubview(categoryNameLabel)
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Configure UI
    func configure(with title: String) {
        categoryNameLabel.snp.makeConstraints { make in
            if sectionKind == .categories {
                make.top.equalTo(self)
                make.bottom.equalTo(self)
            } else {
                make.top.equalTo(self).offset(15)
                make.bottom.lessThanOrEqualTo(0)
            }
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
        }
        
        categoryNameLabel.text = title
    }
}
