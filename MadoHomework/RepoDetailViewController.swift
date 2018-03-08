//
//  RepoDetailViewController.swift
//  MadoHomework
//
//  Created by Jeffrey Blagdon on 3/7/18.
//  Copyright © 2018 Mado Labs. All rights reserved.
//

import UIKit

class RepoDetailViewController: UIViewController {
    private let repo: Repo
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var cloneURLTextView: UITextView!

    init(repo: Repo) {
        self.repo = repo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = repo.name
        descriptionLabel.text = repo.description
        forksCountLabel.text = "Forks: \(repo.forksCount)"
        starsCountLabel.text = "Stars: \(repo.starsCount)"
        cloneURLTextView.text = repo.cloneURL.absoluteString
    }
}
