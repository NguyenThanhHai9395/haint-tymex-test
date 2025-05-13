//
//  UserCacheManager.swift
//  tymex-test
//
//  Created by Hai Nguyen on 13/5/25.
//

import Foundation

protocol UserCacheManagerProtocol {
    func save(users: [GithubUser])
    func load() -> [GithubUser]
}

final class UserCacheManager: UserCacheManagerProtocol {
    private let cacheKey = "cached_users"
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func save(users: [GithubUser]) {
        let data = try? JSONEncoder().encode(users)
        userDefaults.set(data, forKey: cacheKey)
    }

    func load() -> [GithubUser] {
        guard let data = userDefaults.data(forKey: cacheKey),
              let users = try? JSONDecoder().decode([GithubUser].self, from: data) else {
            return []
        }
        return users
    }
}
