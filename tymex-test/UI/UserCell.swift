//
//  UserCell.swift
//  tymex-test
//
//  Created by Hai Nguyen on 10/5/25.
//

import UIKit
import Kingfisher

final class UserCell: UITableViewCell {
    static let identifier = "UserCell"

    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.addShadow()
        return view
    }()
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholderAvatar") // Add placeholder
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()

    private let avatarContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()

    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    private let linkLabel: UILabel = {
        let linkLabel = UILabel()
        linkLabel.font = .systemFont(ofSize: 14)
        linkLabel.textColor = .systemBlue
        linkLabel.numberOfLines = 1
        linkLabel.translatesAutoresizingMaskIntoConstraints = false
        return linkLabel
    }()

    private let separatorView = SeparatorView(height: 0.75)

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, separatorView, linkLabel, UIView()])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none

        avatarContainer.addSubview(avatarImageView)

        contentView.addSubview(container)
        [avatarContainer, stackView].forEach { container.addSubview($0) }
    }

    private func layoutUI() {
        container.pinToEdges(of: contentView, with: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))

        avatarImageView.pinToEdges(of: avatarContainer, with: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))

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

    func configure(with user: GithubUser) {
        nameLabel.text = user.login
        linkLabel.setUnderlinedText(user.htmlUrl)

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
