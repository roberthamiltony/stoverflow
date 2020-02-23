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
    
    /// A label intented to display a name
    private (set) var nameLabel: UILabel!
    
    /// A label intented to display a user's reputation
    private (set) var reputationLabel: UILabel!
    
    /// An image view intented to display a user's profile image
    private (set) var profileImage: UIImageView!
    
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
        mainStack.isUserInteractionEnabled = false
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
        reputation.setContentHuggingPriority(.required, for: .vertical)
        reputationLabel = reputation
        let labelStack = UIStackView()
        labelStack.axis = .vertical
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.addArrangedSubview(name)
        labelStack.addArrangedSubview(reputation)
        let image = UIImageView()
        profileImage = image
        image.translatesAutoresizingMaskIntoConstraints = false
        let mainContentStack = UIStackView()
        mainContentStack.axis = .horizontal
        mainContentStack.translatesAutoresizingMaskIntoConstraints = false
        mainContentStack.addArrangedSubview(image)
        mainContentStack.addArrangedSubview(labelStack)
        image.addConstraints([
            NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: profileImage, attribute: .height, multiplier: 1.0, constant: 0)
        ])
        mainStack.addArrangedSubview(mainContentStack)
    }
    
    private func setupExpandedContent() {
        let follow = UIButton()
        let block = UIButton()
        followButton = follow
        blockButton = block
        // TODO add localisation
        follow.titleLabel?.text = "Follow"
        block.titleLabel?.text = "Block"
        follow.backgroundColor = .systemBlue
        block.backgroundColor = .systemRed
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
    
    required init?(coder: NSCoder) {
        fatalError("Coder init is not supported")
    }
}
