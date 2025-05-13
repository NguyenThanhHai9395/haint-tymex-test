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
    private let cacheManager: UserCacheManagerProtocol
    private var lastUserId: Int = 0
    private var isLoading: Bool = false

    init(service: GithubServiceProtocol, cacheManager: UserCacheManagerProtocol = UserCacheManager()) {
        self.service = service
        self.cacheManager = cacheManager

        self.users = cacheManager.load()
        if let last = users.last {
            self.lastUserId = last.id
        }
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
            cacheManager.save(users: users)

        } catch {
            print("Failed to load more users: \(error)")
        }

    }
}
