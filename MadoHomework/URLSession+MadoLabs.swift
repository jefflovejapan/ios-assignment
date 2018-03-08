//
//  URLSession+MadoLabs.swift
//  MadoHomework
//
//  Created by Jeffrey Blagdon on 3/8/18.
//  Copyright © 2018 Mado Labs. All rights reserved.
//

import Foundation

extension URLSession {
    func request(for endpoint: GitHubEndpoint, observingOn queue: DispatchQueue = .main, withCompletion completion: @escaping (Data?, Error?) -> Void) {
        self.dataTask(with: endpoint.url) { (data, _, err) in
            queue.async {
                completion(data, err)
            }
            }.resume()
    }
}
