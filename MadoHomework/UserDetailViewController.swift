//
//  UserDetailViewController.swift
//  MadoHomework
//
//  Created by Jeffrey Blagdon on 3/7/18.
//  Copyright © 2018 Mado Labs. All rights reserved.
//

import UIKit

class UserDetailRepoCell: UITableViewCell {
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let starCountLabel = UILabel()
    let forkCountLabel = UILabel()
    let stackView = UIStackView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        for label in [nameLabel, descriptionLabel, starCountLabel, forkCountLabel] {
            label.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(label)
        }

        nameLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        starCountLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
        forkCountLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption2)
        contentView.addSubview(stackView)
        stackView.leftAnchor.constraintEqualToSystemSpacingAfter(contentView.leftAnchor, multiplier: 1).isActive = true
        contentView.rightAnchor.constraintEqualToSystemSpacingAfter(stackView.rightAnchor, multiplier: 1).isActive = true
        stackView.topAnchor.constraintEqualToSystemSpacingBelow(contentView.topAnchor, multiplier: 1).isActive = true
        contentView.bottomAnchor.constraintEqualToSystemSpacingBelow(stackView.bottomAnchor, multiplier: 1).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
}

class UserDetailHeaderView: UITableViewHeaderFooterView {
    let avatarImageView = UIImageView()
    let usernameLabel = UILabel()
    let fullnameLabel = UILabel()
    let joinedDateLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    private func configure() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avatarImageView)
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        avatarImageView.topAnchor.constraintEqualToSystemSpacingBelow(contentView.topAnchor, multiplier: 1).isActive = true

        usernameLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        fullnameLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.callout)
        joinedDateLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote)

        for label in [usernameLabel, fullnameLabel, joinedDateLabel] {
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            contentView.addSubview(label)
        }

        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[img]-[username]-[fullname]-[joined]-|", options: .alignAllCenterX, metrics: nil, views: ["img": avatarImageView, "username": usernameLabel, "fullname": fullnameLabel, "joined": joinedDateLabel])
        NSLayoutConstraint.activate(vConstraints)
    }
}

class UserDetailViewController: UITableViewController {

    // MARK: Properties

    let user: User
    let repos: [Repo]
    var avatarImage: UIImage? {
        didSet {
            if let header = tableView?.headerView(forSection: 0) as? UserDetailHeaderView {
                header.avatarImageView.image = avatarImage
            }
        }
    }

    // MARK: Initialization

    init(user: User, repos: [Repo]) {
        self.user = user
        self.repos = repos
        super.init(nibName: nil, bundle: nil)
        self.title = user.name
        URLSession.shared.request(for: .avatar(user.avatarURL)) { [weak self] (maybeData, maybeError) in
            self?.avatarImage = maybeData.flatMap { UIImage(data: $0) }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(closeButtonTapped))
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 120
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.register(cellClass: UserDetailRepoCell.self)
        tableView.registerHeaderFooter(headerFooterClass: UserDetailHeaderView.self)
    }

    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserDetailRepoCell = tableView.dequeue(for: indexPath)
        let repo = repos[indexPath.row]
        cell.nameLabel.text = repo.name
        cell.descriptionLabel.text = repo.description
        cell.forkCountLabel.text = "Forks: \(repo.forksCount)"
        cell.starCountLabel.text = "Stars: \(repo.starsCount)"
        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: UserDetailHeaderView = tableView.dequeueHeaderFooter()
        header.avatarImageView.image = avatarImage
        header.usernameLabel.text = user.name
        header.fullnameLabel.text = "Jeff Blagdon"
        header.joinedDateLabel.text = "Sept. 11, 2001"
        return header
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = repos[indexPath.row]
        presentDetail(for: repo)
    }

    // MARK: Helper methods

    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    private func presentDetail(for repo: Repo) {
        let vc = RepoDetailViewController(repo: repo)
        navigationController?.pushViewController(vc, animated: true)
    }
}
