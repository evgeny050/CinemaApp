//
//  SectionHeaderView.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 25.03.2024.
//

import UIKit
import SnapKit

class SectionHeaderView: UICollectionReusableView {
    
    static let reuseId = "SectionHeader"
    
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeElements()
        setupConstraints()
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Layout
extension SectionHeaderView {
    private func customizeElements() {
        title.textColor = .black
        title.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        title.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        addSubview(title)
        title.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
