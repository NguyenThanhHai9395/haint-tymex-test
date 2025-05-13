//
//  UserDetailStatView.swift
//  tymex-test
//
//  Created by Hai Nguyen on 11/5/25.
//

import UIKit

final class UserDetailStatView: UIView {

    private lazy var iconContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .label
        iconView.translatesAutoresizingMaskIntoConstraints = false
        return iconView
    }()

    private let valueLabel = UILabel()
    private let titleLabel = UILabel()

    init(icon: UIImage?, value: Int, title: String) {
        super.init(frame: .zero)
        setupUI()
        configure(icon: icon, value: value, title: title)
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {

        valueLabel.font = .boldSystemFont(ofSize: 16)
        valueLabel.textAlignment = .center

        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .gray
        titleLabel.textAlignment = .center

        iconContainerView.addSubview(iconView)
        iconView.pinToEdges(of: iconContainerView, with: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        iconContainerView.anchor(
            widthConstant: 48, heightConstant: 48
        )
        iconView.centerInSuperview()

        let stack = UIStackView(arrangedSubviews: [iconContainerView, valueLabel, titleLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 6

        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.pinToEdges(of: self)
    }

    func configure(icon: UIImage?, value: Int, title: String) {
        iconView.image = icon
        valueLabel.text = formattedShortNumber(value)
        titleLabel.text = title
    }

    func formattedShortNumber(_ value: Int) -> String {
        switch value {
        case 0..<10:
            return "\(value)"
        case 10..<1000:
            let base = Int(pow(10.0, Double(String(value).count - 1)))
            let rounded = (value / base) * base
            return "\(rounded)+"
        case 1000..<1_000_000:
            let rounded = value / 1000
            return "\(rounded)K+"
        default:
            let rounded = value / 1_000_000
            return "\(rounded)M+"
        }
    }
}
