//
//  MockGithubService.swift
//  tymex-test
//
//  Created by Hai Nguyen on 13/5/25.
//

import XCTest
@testable import tymex_test

// MARK: - Mock Service
class MockGithubService: GithubServiceProtocol {
    var shouldFail = false
    var returnedDetail: GithubUserDetail?

    func fetchUsers(since: Int) async throws -> [GithubUser] {
        if shouldFail {
            throw URLError(.timedOut)
        }

        return [
            GithubUser(id: since + 1, login: "user1", avatarUrl: "url1", htmlUrl: "html1"),
            GithubUser(id: since + 2, login: "user2", avatarUrl: "url2", htmlUrl: "html2")
        ]
    }

//    func fetchUserDetail(username: String) async throws -> GithubUserDetail {
//        fatalError("Not used in this test")
//    }

    func fetchUserDetail(username: String) async throws -> GithubUserDetail {
        if shouldFail {
            throw URLError(.timedOut)
        }
        return returnedDetail ?? GithubUserDetail(
            login: "mockuser",
            name: "Mock User",
            htmlUrl: "https://github.com/mock",
            followers: 100,
            location: "Mockland",
            following: 50,
            blog: "https://mock.blog",
            avatarUrl: "https://mock.avatar"
        )
    }
}
