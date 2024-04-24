//
//  CategoriesCell.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 26.03.2024.
//

import UIKit

final class CategoryCell: UICollectionViewCell, CellModelRepresanteble {
    // MARK: - Properties
    var viewModel: CellViewModelProtocol? {
        didSet {
            updateView()
        }
    }
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9205616117, green: 0.9205616117, blue: 0.9205616117, alpha: 1)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        contentView.addSubview(categoryNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Layout
    private func updateView() {
        guard let viewModel = viewModel as? CellViewModel else { return }
        
        categoryNameLabel.snp.makeConstraints { make in
            if viewModel.isFact {
                make.top.equalTo(contentView).offset(15)
                make.bottom.lessThanOrEqualTo(0)
            } else {
                make.top.equalTo(contentView)
                make.bottom.equalTo(contentView)
            }
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
        }
        categoryNameLabel.text = viewModel.cellItemName
        self.hideSkeleton()
    }
}
