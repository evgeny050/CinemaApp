//
//  CategoriesCell.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 26.03.2024.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let reuseId = "CategoryCell"
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.helveticaBold.rawValue, size: 13)
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9205616117, green: 0.9205616117, blue: 0.9205616117, alpha: 1)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        setupLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup layout of cell
    private func setupLabelConstraints() {
        addSubview(categoryNameLabel)
        
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        categoryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(20)
            make.bottom.equalTo(self)
            make.right.equalTo(self).offset(-20)
        }
    }
    
    func configure(with title: String) {
        categoryNameLabel.text = title
    }
}
