//
//  GitHubEndpoint.swift
//  MadoHomework
//
//  Created by Jeffrey Blagdon on 3/7/18.
//  Copyright © 2018 Mado Labs. All rights reserved.
//

import Foundation

typealias Username = String

enum GitHubEndpoint {
    case user(Username)
    case repos(Username)
    case repo(Username, String)
    case avatar(URL)

    static let rootURL: URL = URL(string: "https://api.github.com")!

    var url: URL {
        switch self {
        case let .user(username):
            return GitHubEndpoint.rootURL.appendingPathComponent("users/\(username)")
        case let .repos(username):
            return GitHubEndpoint.rootURL.appendingPathComponent("users/\(username)/repos")
        case let .repo(username, repo):
            return GitHubEndpoint.rootURL.appendingPathComponent("repos/\(username)/\(repo)")
        case let .avatar(url):
            return url
        }
    }
}
