//
//  GithubUserDetail.swift
//  tymex-test
//
//  Created by Hai Nguyen on 10/5/25.
//

struct GithubUserDetail: Codable {
    let login: String
    let name: String?
    let htmlUrl: String
    let followers: Int
    let location: String?
    let following: Int
    let blog: String?
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case login
        case name
        case htmlUrl = "html_url"
        case followers
        case location
        case following
        case blog
        case avatarUrl = "avatar_url"
    }
}

