//
//  GithubUser.swift
//  tymex-test
//
//  Created by Hai Nguyen on 10/5/25.
//

struct GithubUser: Codable, Hashable {
    let id: Int
    let login: String
    let avatar_url: String
}
