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
        title = "GitHub Users"
        setupUI()
        bindViewModel()
        fetchData()
    }

    private func setupUI() {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
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
        let user = viewModel.users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = user.login
        config.secondaryText = "ID: \(user.id)"
        cell.contentConfiguration = config

        if indexPath.row == viewModel.users.count - 1 {
            Task { await viewModel.loadMore() }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.users[indexPath.row]
        delegate?.userListVC(didSelectUser: user)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
