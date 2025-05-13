//
//  UserCardView.swift
//  tymex-test
//
//  Created by Hai Nguyen on 12/5/25.
//

import UIKit
import Kingfisher

final class UserCardView: UIView {

    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.addShadow()
        return view
    }()

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholderAvatar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var avatarContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var separatorView = SeparatorView(height: 0.75)
    private lazy var locationView = LocationView(location: " ")

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, separatorView, locationView, UIView()])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        layoutUI()
    }

    // MARK: - Setup

    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        avatarContainer.addSubview(avatarImageView)
        addSubview(container)
        container.addSubview(avatarContainer)
        container.addSubview(stackView)
    }

    private func layoutUI() {
        container.pinToEdges(of: self)

        avatarImageView.pinToEdges(of: avatarContainer, with: .init(top: 8, left: 8, bottom: 8, right: 8))

        avatarContainer.anchor(
            top: container.topAnchor, topConstant: 12,
            leading: container.leadingAnchor, leadingConstant: 12,
            widthConstant: 96,
            heightConstant: 96
        )
        avatarContainer.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true

        stackView.anchor(
            top: container.topAnchor, topConstant: 16,
            leading: avatarContainer.trailingAnchor, leadingConstant: 12,
            trailing: container.trailingAnchor, trailingConstant: 12,
            bottom: container.bottomAnchor, bottomConstant: 16
        )
    }

    // MARK: - Configure

    func configure(with user: GithubUserDetail) {
        nameLabel.text = user.login
        locationView.location = user.location

        if let url = URL(string: user.avatarUrl) {
            avatarImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholderAvatar"),
                options: [
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ]
            )
        } else {
            avatarImageView.image = UIImage(named: "placeholderAvatar")
        }
    }
}
