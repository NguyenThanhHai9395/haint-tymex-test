//
//  GithubService.swift
//  tymex-test
//
//  Created by Hai Nguyen on 10/5/25.
//
import Foundation

protocol GithubServiceProtocol {
    func fetchUsers(since: Int) async throws -> [GithubUser]
    func fetchUserDetail(username: String) async throws -> GithubUserDetail
}


class GithubService: GithubServiceProtocol {
    func fetchUsers(since: Int) async throws -> [GithubUser] {
        let url = URL(string: "https://api.github.com/users?since=\(since)&per_page=20")
        let (data, _) = try await URLSession.shared.data(from: url!)
        return try JSONDecoder().decode([GithubUser].self, from: data)
    }
    
    func fetchUserDetail(username: String) async throws -> GithubUserDetail {
        let url = URL(string: "https://api.github.com/users/\(username)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(GithubUserDetail.self, from: data)
    }

}
