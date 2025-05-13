//
//  GithubUser.swift
//  tymex-test
//
//  Created by Hai Nguyen on 10/5/25.
//

struct GithubUser: Codable, Hashable {
    let id: Int
    let login: String
    let avatarUrl: String
    let htmlUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
}
