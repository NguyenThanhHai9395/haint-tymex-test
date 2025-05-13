//
//  UIStackView+Extension.swift
//  tymex-test
//
//  Created by Hai Nguyen on 13/5/25.
//
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }

    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
