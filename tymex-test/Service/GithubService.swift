//
//  GithubService.swift
//  tymex-test
//
//  Created by Hai Nguyen on 10/5/25.
//
import Foundation

enum GithubAPI {
    case fetchUsers(since: Int, perPage: Int = 20)
    case fetchUserDetail(username: String)

    var url: URL? {
        switch self {
        case .fetchUsers(let since, let perPage):
            var components = URLComponents(string: "https://api.github.com/users")
            components?.queryItems = [
                URLQueryItem(name: "since", value: "\(since)"),
                URLQueryItem(name: "per_page", value: "\(perPage)")
            ]
            return components?.url

        case .fetchUserDetail(let username):
            return URL(string: "https://api.github.com/users/\(username)")
        }
    }
}

protocol GithubServiceProtocol {
    func fetchUsers(since: Int) async throws -> [GithubUser]
    func fetchUserDetail(username: String) async throws -> GithubUserDetail
}

class GithubService: GithubServiceProtocol {
    func fetchUsers(since: Int) async throws -> [GithubUser] {
        guard let url = GithubAPI.fetchUsers(since: since).url else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([GithubUser].self, from: data)
    }
    
    func fetchUserDetail(username: String) async throws -> GithubUserDetail {
        guard let url = GithubAPI.fetchUserDetail(username: username).url else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(GithubUserDetail.self, from: data)
    }

}
