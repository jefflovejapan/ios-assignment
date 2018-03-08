//
//  GitHubData.swift
//  MadoHomework
//
//  Created by Jeffrey Blagdon on 3/8/18.
//  Copyright © 2018 Mado Labs. All rights reserved.
//

import Foundation

struct User: Codable {
    var name: String
    var avatarURL: URL
    var createdDate: Date

    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarURL = "avatar_url"
        case createdDate = "created_at"
    }
}

struct Repo: Codable {
    var name: String
    var description: String?
    var forksCount: Int
    var starsCount: Int
    var cloneURL: URL

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case forksCount = "forks_count"
        case starsCount = "stargazers_count"
        case cloneURL = "clone_url"
    }
}
