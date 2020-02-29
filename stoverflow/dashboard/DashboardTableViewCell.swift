//
//  DashboardTableViewCell.swift
//  stoverflow
//
//  Created by Robert Hamilton on 22/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit

/// A table view cell intented to display a picture, name and reputation for a stack overflow user as well as an expanded state
/// with buttons.
class DashboardTableViewCell: UITableViewCell {
    
    /// A view model backing this instance
    var viewModel: DashboardTableViewCellViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    /// A delegate to handle updates from this instance
    weak var delegate: DashboardTableViewCellDelegate?
    
    /// Whether the cell is in its expanded state
    var isExpanded: Bool {
        return !mainStack.arrangedSubviews[1].isHidden
    }
    
    /// A label intented to display a name
    private (set) var nameLabel: UILabel!
    
    /// A label intented to display a user's reputation
    private (set) var reputationLabel: UILabel!
    
    /// An image view intented to display a user's profile image
    private (set) var profileImage: UIImageView!
    
    /// An image to indicate that the user is being followed
    private (set) var followingIndicator: UIImageView!
    
    /// A button intented to initiate the process of following a user
    private (set) var followButton: UIButton!
    
    /// A button intented to initate the process of blocking a user
    private (set) var blockButton: UIButton!
    
    private var mainStack: UIStackView!
    private var expandedStack: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContent()
    }
    
    private func setupContent() {
        mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.spacing = 20
        contentView.addSubview(mainStack)
        mainStack.makeEqualToSuperview()
        setupMainContent()
        setupExpandedContent()
    }
    
    private func setupMainContent() {
        let name = UILabel()
        let reputation = UILabel()
        nameLabel = name
        nameLabel.setContentHuggingPriority(.required, for: .vertical)
        nameLabel.accessibilityIdentifier = "name"
        reputation.setContentHuggingPriority(.required, for: .vertical)
        reputationLabel = reputation
        reputation.accessibilityIdentifier = "reputation"
        let labelStack = UIStackView()
        labelStack.axis = .vertical
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.addArrangedSubview(name)
        labelStack.addArrangedSubview(reputation)
        let image = UIImageView()
        profileImage = image
        image.layer.cornerRadius = 5.0
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.accessibilityIdentifier = "profileImage"
        let followIndicator = UIImageView()
        followingIndicator = followIndicator
        followIndicator.translatesAutoresizingMaskIntoConstraints = false
        followIndicator.image = UIImage(systemName: "hand.thumbsup")
        followIndicator.tintColor = .label
        let mainContentStack = UIStackView()
        mainContentStack.axis = .horizontal
        mainContentStack.translatesAutoresizingMaskIntoConstraints = false
        mainContentStack.addArrangedSubview(image)
        mainContentStack.addArrangedSubview(labelStack)
        mainContentStack.addArrangedSubview(followIndicator)
        mainContentStack.spacing = 10.0
        mainContentStack.isUserInteractionEnabled = false
        image.widthEqualHeight()
        followIndicator.widthEqualHeight()
        mainStack.addArrangedSubview(mainContentStack)
    }
    
    private func setupExpandedContent() {
        let follow = UIButton()
        let block = UIButton()
        followButton = follow
        blockButton = block
        // TODO 2: add localisation
        follow.setTitle("Follow", for: .normal)
        follow.accessibilityIdentifier = "follow"
        block.setTitle("Block", for: .normal)
        block.accessibilityIdentifier = "block"
        follow.backgroundColor = .systemBlue
        block.backgroundColor = .systemRed
        follow.addTarget(self, action: #selector(didSelectFollow(_:)), for: .touchUpInside)
        block.addTarget(self, action: #selector(didSelectBlocked(_:)), for: .touchUpInside)
        [follow, block].forEach {
            $0.layer.cornerRadius = 5.0
            $0.layer.masksToBounds = true
            $0.isUserInteractionEnabled = true
        }
        let expanded = UIStackView()
        expandedStack = expanded
        expanded.axis = .horizontal
        expanded.spacing = 20.0
        expanded.distribution = .fillEqually
        expanded.addArrangedSubview(follow)
        expanded.addArrangedSubview(block)
        mainStack.addArrangedSubview(expanded)
        toggleExpandedState()
    }
    
    /// Toggles the state of the cell to show or hide the buttons, depending on the current state. The table view containing the
    /// cell will need to be notified of the change for this to be properly displayed
    func toggleExpandedState() {
        mainStack.arrangedSubviews[1].isHidden = !mainStack.arrangedSubviews[1].isHidden
    }
    
    @objc private func didSelectFollow(_ sender: Any?) {
        if let viewModel = viewModel {
            if let following = viewModel.following {
                viewModel.following = !following
            }
        }
    }
    
    @objc private func didSelectBlocked(_ select: Any?) {
        if let viewModel = viewModel {
            if let blocked = viewModel.blocked {
                viewModel.blocked = !blocked
            }
        }
    }
    
    private func bindViewModel() {
        if let viewModel = viewModel {
            viewModel.delegate = self
            nameLabel.text = viewModel.user.displayName
            reputationLabel.text = String(viewModel.user.reputation)
            if let imageData = viewModel.profileImageData {
                profileImage.image = UIImage(data: imageData)
            }
            updateFollowButton()
            updateBlockedButton()
        }
    }
    
    private func updateFollowButton() {
        if let viewModel = viewModel {
            let isFollowing = viewModel.following ?? false
            followButton.alpha = isFollowing ? 0.5 : 1.0
            followButton.setTitle(isFollowing ? "Following" : "Follow", for: .normal)
            followingIndicator.alpha = isFollowing ? 1 : 0
        }
    }
    
    private func updateBlockedButton() {
        if let viewModel = viewModel  {
            let isBlocked = (viewModel.blocked ?? false)
            contentView.alpha = isBlocked ? 0.5 : 1.0
            isUserInteractionEnabled = !isBlocked
            if isBlocked {
                delegate?.didBlockUser(self)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("Coder init is not supported")
    }
}

extension DashboardTableViewCell: DashboardTableViewCellViewModelDelegate {
    func viewModelDidUpdateFollowingState(_ viewModel: DashboardTableViewCellViewModel) {
        updateFollowButton()
    }
    
    func viewModelDidUpdateBlockedState(_ viewModel: DashboardTableViewCellViewModel) {
        updateBlockedButton()
    }
}

/// A protocol to be implemented to handle updates from DashboardTableViewCell instances
protocol DashboardTableViewCellDelegate: class {
    
    /// Called when the blocked state of the cell's user becomes true
    /// - Parameter cell: The cell which is handling a now blocked user
    func didBlockUser(_ cell: DashboardTableViewCell)
}
