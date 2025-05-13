//
//  UserListVC.swift
//  tymex-test
//
//  Created by Hai Nguyen on 10/5/25.
//

import Foundation
import UIKit
import Combine

protocol UserListVCDelegate: AnyObject {
    func userListVC(didSelectUser user: GithubUser)
}

class UserListVC: UIViewController {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let tableView = UITableView()
    private let viewModel: UserListViewModel
    private var cancelables: Set<AnyCancellable> = []
    weak var delegate: UserListVCDelegate?


    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        fetchData()
    }

    private func setupUI() {
        title = "GitHub Users"
        view.backgroundColor = UIColor.systemGroupedBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        view.addSubview(tableView)
        tableView.pinToEdges(of: view)
    }

    private func bindViewModel() {
        viewModel.$users
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancelables)
    }

    private func fetchData() {
        Task {
            await viewModel.loadInitial()
        }
    }
}

extension UserListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        let user = viewModel.users[indexPath.row]
        cell.configure(with: user)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.users[indexPath.row]
        delegate?.userListVC(didSelectUser: user)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let threshold: CGFloat = 100
        if offsetY > contentHeight - scrollView.frame.height - threshold {
            Task {
                await viewModel.loadMore()
            }
        }
    }
}
