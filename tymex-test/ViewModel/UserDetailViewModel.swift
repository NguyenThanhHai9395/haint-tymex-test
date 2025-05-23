//
//  UserDetailViewModel.swift
//  tymex-test
//
//  Created by Hai Nguyen on 10/5/25.
//

import Combine
import Foundation

class UserDetailViewModel: ObservableObject {
    @Published private(set) var userDetail: GithubUserDetail?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    private let userName: String
    private let service: GithubServiceProtocol

    init(userName: String, service: GithubServiceProtocol) {
        self.userName = userName
        self.service = service
    }

    /// Loads the user detail asynchronously for the specified username.
    ///
    /// This method sets `isLoading` to `true` while performing the network request,
    /// then updates the `userDetail` property on success or `errorMessage` on failure.
    ///
    /// Call this method from an asynchronous context, such as inside a `Task`.
    ///
    /// Example:
    /// ```
    /// Task {
    ///     await viewModel.load()
    /// }
    /// ```
    func load() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let detail = try await service.fetchUserDetail(username: userName)
            self.userDetail = detail
        } catch {
            self.errorMessage = "Failed to load user detail."
        }
    }
}
