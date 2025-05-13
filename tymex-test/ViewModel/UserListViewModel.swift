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

    /// Initializes the view model with a service and a cache manager.
    /// - Parameters:
    ///   - service: The service to fetch GitHub users.
    ///   - cacheManager: An optional cache manager to persist user data. Defaults to `UserCacheManager`.
    init(service: GithubServiceProtocol, cacheManager: UserCacheManagerProtocol = UserCacheManager()) {
        self.service = service
        self.cacheManager = cacheManager

        self.users = cacheManager.load()
        if let last = users.last {
            self.lastUserId = last.id
        }
    }

    /// Loads the initial set of users.
    ///
    /// If users have already been loaded or cached, it does not reload.
    /// Otherwise, it calls `loadMore()` to fetch new data.
    func loadInitial() async {
        if !users.isEmpty {
            return
        }
        await loadMore()
    }


    /// Loads more users from GitHub, appending them to the current list.
    ///
    /// This function respects pagination by using the last user ID
    /// and avoids duplicate loading by guarding with the `isLoading` flag.
    /// On success, the newly fetched users are appended to `users` and saved to cache.
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
