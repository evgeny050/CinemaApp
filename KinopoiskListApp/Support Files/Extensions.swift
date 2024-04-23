//
//  Extensions.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 20.03.2024.
//
import UIKit

extension UIView {
    func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
}

extension Date {
    func formatString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter.string(from: self)
    }
}

extension UITableView {
    func updateHeaderViewHeight() {
        if let header = self.tableHeaderView {
            let newSize = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
            header.frame.size.height = newSize.height + 3
        }
    }
}

extension UILabel {
    var maxNumberOfLines: Int {
        let lineHeight = font.lineHeight
        return Int(ceil(self.textHeight / lineHeight))
    }
    
    var textHeight: CGFloat {
        let maxSize = CGSize(
            width: (superview?.bounds.width ?? UIScreen.main.bounds.width) - 20,
            height: CGFloat(MAXFLOAT)
        )
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(
            with: maxSize,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        ).height
        return textHeight
    }
}


