//
//  UserDetailVC.swift
//  tymex-test
//
//  Created by Hai Nguyen on 10/5/25.
//

import UIKit
import Combine

class UserDetailVC: UIViewController {

    private let viewModel: UserDetailViewModel
    private var cancellables = Set<AnyCancellable>()
    private let label = UILabel()

    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "User Detail"
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
        view.backgroundColor = .systemBackground
        label.numberOfLines = 0
        label.textAlignment = .center
        label.frame = view.bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(label)
    }

    private func bindViewModel() {
        viewModel.$userDetail
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] detail in
                self?.label.text = """
                        Username: \(detail.login)
                        Name: \(detail.name ?? "N/A")
                        Location: \(detail.location ?? "Unknown")
                        Public Repos: \(detail.public_repos)
                        Followers: \(detail.followers)
                        """
            }
            .store(in: &cancellables)
    }

    private func featchData() {
        Task {
            await viewModel.load()
        }
    }

}
