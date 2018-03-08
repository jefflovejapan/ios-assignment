//
//  ViewController.swift
//  MadoHomework
//
//  Created by Nicholas Sillik on 12/7/17.
//  Copyright © 2017 Mado Labs. All rights reserved.
//

import UIKit

class UsernameEntryViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        showError(nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        usernameField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        usernameField.resignFirstResponder()
    }

    // MARK: IBActions
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        fetchUser()
    }

    @IBAction func goButtonTapped(_ sender: Any) {
        fetchUser()
    }

    // MARK: Helper methods

    private func fetchUser() {
        guard let username = usernameField.text, !username.isEmpty else {
            showError("Please enter a valid username")  // Wouldn't want these string literals everywhere in production, probably want an Error type
            return
        }
        showError(nil)
        usernameField.resignFirstResponder()
        let userEndpoint: GitHubEndpoint = .user(username)

        URLSession.shared.request(for: userEndpoint) { [weak self] (maybeData, maybeError) in
            guard let data = maybeData else {
                self?.showError("Error loading user \"\(username)\"")
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let user: User
            do {
                try user = decoder.decode(User.self, from: data)
            } catch {
                print("Error decoding user: \(error)")
                self?.showError("Error loading user \"\(username)\"")
                return
            }
            URLSession.shared.request(for: .repos(username), withCompletion: { [weak self] (maybeData, maybeError) in
                guard let data = maybeData else {
                    self?.showError("Error loading repos for user \"\(username)\"")
                    return
                }
                let repos: [Repo]
                do {
                    try repos = JSONDecoder().decode([Repo].self, from: data)
                } catch {
                    print("Error decoding repos: \(error)")
                    self?.showError("Error loading repos for user \"\(username)\"")
                    return
                }
                self?.presentUserDetail(for: user, with: repos)
            })
        }
    }

    private func presentUserDetail(for user: User, with repos: [Repo]) {
        let detailVC = UserDetailViewController(user: user, repos: repos)
        let nav = UINavigationController(rootViewController: detailVC)
        present(nav, animated: true, completion: nil)
    }

    private func showError(_ error: String?) {
        errorLabel.isHidden = error == nil
        errorLabel.text = error
    }
}

