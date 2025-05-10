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
    private let service: GithubService

    init(userName: String, service: GithubService) {
        self.userName = userName
        self.service = service
    }

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
