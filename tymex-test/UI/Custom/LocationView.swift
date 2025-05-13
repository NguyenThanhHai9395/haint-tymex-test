//
//  LocationView.swift
//  tymex-test
//
//  Created by Hai Nguyen on 12/5/25.
//

import UIKit

final class LocationView: UIView {

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "mappin.and.ellipse")
        imageView.image = image
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var location: String? {
        didSet {
            locationLabel.text = location ?? "Unknown"
        }
    }

    init(location: String?) {
        super.init(frame: .zero)
        locationLabel.text = location ?? "Unknown"
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconImageView)
        addSubview(locationLabel)

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: 16),

            locationLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 6),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationLabel.topAnchor.constraint(equalTo: topAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
