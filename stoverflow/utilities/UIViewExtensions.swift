//
//  UIViewExtensions.swift
//  stoverflow
//
//  Created by Robert Hamilton on 22/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// Adds constraints to make a view equal to its superview
    /// - Parameter insets: An UIEdgeInsets instance to configure the spacing to the superview. By default, all values
    ///  are zero
    func makeEqualToSuperview(insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        superview?.addConstraints([
            NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: superview, attribute: .leftMargin, multiplier: 1, constant: insets.left),
            NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: superview, attribute: .rightMargin, multiplier: 1, constant: insets.right),
            NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .topMargin, multiplier: 1, constant: insets.top),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottomMargin, multiplier: 1, constant: insets.bottom)
        ])
    }
    
    /// Adds constraints to make a view centred within its superview.
    func centreInSuperview() {
        superview?.addConstraints([
            NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1.0, constant: 0)
        ])
    }
}
