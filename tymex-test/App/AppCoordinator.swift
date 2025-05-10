//
//  AppCoordinator.swift
//  tymex-test
//
//  Created by Hai Nguyen on 10/5/25.
//
import Foundation
import UIKit

class AppCoordinator {
    private var window: UIWindow
    private var navigationController: UINavigationController
    private var githubService: GithubService

    init(window: UIWindow,
         navigationController: UINavigationController = UINavigationController(),
         githubService: GithubService = GithubService()) {
        self.window = window
        self.navigationController = navigationController
        self.githubService = githubService
    }

    func start() {
        let viewModel = UserListViewModel(service: githubService)
        let userListVC = UserListVC(viewModel: viewModel)
        userListVC.delegate = self

        navigationController.viewControllers = [userListVC]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator : UserListVCDelegate {
    func userListVC(didSelectUser user: GithubUser) {
        let detailViewModel = UserDetailViewModel(userName: user.login, service: self.githubService)
        let vc = UserDetailVC(viewModel: detailViewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    

}
