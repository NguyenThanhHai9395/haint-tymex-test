//
//  SeparatorView.swift
//  tymex-test
//
//  Created by Hai Nguyen on 12/5/25.
//
import UIKit

final class SeparatorView: UIView {

    init(height: CGFloat = 1.0, color: UIColor = .separator) {
        super.init(frame: .zero)
        backgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
