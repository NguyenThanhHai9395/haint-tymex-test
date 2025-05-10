//
//  UserListViewModel.swift
//  tymex-test
//
//  Created by Hai Nguyen on 10/5/25.
//
import Combine
import Foundation

class UserListViewModel: ObservableObject {
    @Published private(set) var users: [GithubUser] = []
    private let service: GithubServiceProtocol
    private var lastUserId: Int = 0
    private var isLoading: Bool = false

    init(service: GithubServiceProtocol) {
        self.service = service
    }

    func loadInitial() async {
        if !users.isEmpty {
            return
        }
        await loadMore()
    }

    func loadMore() async {
        guard !isLoading else {
            return
        }
        isLoading = true
        defer {
            isLoading = false
        }

        do {
            let newUsers = try await service.fetchUsers(since: lastUserId)
            self.users.append(contentsOf: newUsers)
            self.lastUserId = newUsers.last?.id ?? self.lastUserId

        } catch {
            print("Failed to load more users: \(error)")
        }

    }
}
