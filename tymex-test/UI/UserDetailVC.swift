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

    private lazy var infoView: UIView = {
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


    private lazy var followerStat = UserDetailStatView(icon: UIImage(systemName: "person.2.fill"), value: 0, title: "Follower")
    private lazy var followingStat = UserDetailStatView(icon: UIImage(systemName: "person.fill.badge.plus"), value: 0, title: "Following")

    private lazy var blogLabel: UILabel = {
        let label = UILabel()
        label.text = "Blog"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var blogLinkLabel: UILabel = {
        let label = UILabel()
        label.text = "Blog"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.systemGray2
        return label
    }()

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private lazy var mainStack: UIStackView = {
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 24
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
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
        view.addSubview(loadingIndicator)

        loadingIndicator.centerInSuperview()

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

        mainStack.addArrangedSubviews(userCardView, statsStack, blogStack)

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

        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self else { return }
                if isLoading {
                    self.loadingIndicator.startAnimating()
                } else {
                    self.loadingIndicator.stopAnimating()
                }
                self.mainStack.isHidden = isLoading
            }
            .store(in: &cancellables)
    }

    private func featchData() {
        Task {
            await viewModel.load()
        }
    }
}
