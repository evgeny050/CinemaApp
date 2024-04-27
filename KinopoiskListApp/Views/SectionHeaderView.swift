//
//  SectionHeaderView.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 25.03.2024.
//

import UIKit
import SnapKit

class SectionHeaderView: UICollectionReusableView {
    
    let title: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSkeletonable = true
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        title.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
}
