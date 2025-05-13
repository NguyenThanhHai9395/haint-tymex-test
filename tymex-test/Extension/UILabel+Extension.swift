//
//  UILabel+Extension.swift
//  tymex-test
//
//  Created by Hai Nguyen on 12/5/25.
//

import UIKit

extension UILabel {
    func setUnderlinedText(_ text: String, color: UIColor? = nil) {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: color ?? self.textColor ?? .label
        ]
        self.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
}
