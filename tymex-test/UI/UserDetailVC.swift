//
//  UserDetailVC.swift
//  tymex-test
//
//  Created by Hai Nguyen on 10/5/25.
//

import UIKit
import Combine


class UserDetailVC: BaseVC {

    private let viewModel: UserDetailViewModel
    private var cancellables = Set<AnyCancellable>()

    private let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var userCardView: UserCardView = {
        let view = UserCardView()
        return view
    }()


    private let followerStat = UserDetailStatView(icon: UIImage(systemName: "person.2.fill"), value: 0, title: "Follower")
    private let followingStat = UserDetailStatView(icon: UIImage(systemName: "person.fill.badge.plus"), value: 0, title: "Following")

    private let blogLabel: UILabel = {
        let label = UILabel()
        label.text = "Blog"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let blogLinkLabel: UILabel = {
        let label = UILabel()
        label.text = "Blog"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.systemGray2
        return label
    }()

    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "User Details"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        featchData()
    }

    private func setupUI() {
        configBackButton()
        view.backgroundColor = .systemBackground

        view.addSubview(userCardView)

        userCardView.anchor(
            heightConstant: 120
        )

        let statsStack = UIStackView(arrangedSubviews: [followerStat, followingStat])
        statsStack.axis = .horizontal
        statsStack.spacing = 24
        statsStack.distribution = .fillEqually

        let blogStack = UIStackView(arrangedSubviews: [blogLabel, blogLinkLabel])
        blogStack.axis = .vertical
        blogStack.spacing = 6

        let mainStack = UIStackView(arrangedSubviews: [userCardView, statsStack, blogStack])
        mainStack.axis = .vertical
        mainStack.spacing = 24
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func bindViewModel() {
        viewModel.$userDetail
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] detail in
                guard let self else { return }

                userCardView.configure(with: detail)
                followerStat.configure(icon: UIImage(systemName: "person.2.fill"), value: detail.followers, title: "Follower")
                followingStat.configure(icon: UIImage(systemName: "person.fill.badge.plus"), value: detail.following, title: "Following")
                blogLinkLabel.text = detail.blog ?? "No blog"

            }
            .store(in: &cancellables)
    }

    private func featchData() {
        Task {
            await viewModel.load()
        }
    }
}
