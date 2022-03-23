//
//  Viewable.swift
//  tien.viper
//
//  Created by Valerian on 23/03/2022.
//

import Foundation

struct GitHubRepository: Codable {
    let id: Int
    let fullName: String
    let description: String
    let stargazersCount: Int
    let url: String

    private enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case description
        case stargazersCount = "stargazers_count"
        case url = "html_url"
    }
}

struct SearchRepositoriesResponse: Codable {
    let items: [GitHubRepository]
}
