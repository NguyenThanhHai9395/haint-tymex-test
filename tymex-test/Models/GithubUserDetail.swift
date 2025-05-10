//
//  GithubUserDetail.swift
//  tymex-test
//
//  Created by Hai Nguyen on 10/5/25.
//

struct GithubUserDetail: Codable {
    let login: String
    let name: String?
    let public_repos: Int
    let followers: Int
    let location: String?
}
