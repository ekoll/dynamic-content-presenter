//
//  ConstraintsExtensions.swift
//  DynamicContent
//
//  Created by Ekrem Duvarbasi on 21.01.2023.
//

import UIKit

extension UIView {

    func fitInto(_ view: AnyObject, topInset: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false

        let constraints: [NSLayoutConstraint] = [
            .init(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: topInset),
            .init(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: leading),
            .init(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: trailing),
            .init(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: bottom)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func centerInto(_ view: AnyObject, hPadding: CGFloat = 0, vPadding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false

        let constraints: [NSLayoutConstraint] = [
            .init(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: hPadding),
            .init(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: vPadding)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func fixHeight(_ size: CGFloat, withAspectRatio aspectRatio: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false

        heightAnchor.constraint(equalToConstant: size).isActive = true

        if let ratio = aspectRatio {
            heightAnchor.constraint(equalTo: widthAnchor, multiplier: ratio, constant: 0).isActive = true
        }
    }

    func fixWidth(_ size: CGFloat, withAspectRatio aspectRatio: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false

        widthAnchor.constraint(equalToConstant: size).isActive = true

        if let ratio = aspectRatio {
            widthAnchor.constraint(equalTo: heightAnchor, multiplier: ratio, constant: 0).isActive = true
        }
    }

    func fixAspectRatio(_ ratio: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: ratio).isActive = true
    }

    func setConstraints(with view: AnyObject, constraints: Constraint...) {
        translatesAutoresizingMaskIntoConstraints = false

        let constraints = constraints.map { constraint -> NSLayoutConstraint in
            let firstView = constraint.isReversed ? view : self
            let secondView = constraint.isReversed ? self : view

            return .init(item: firstView, attribute: constraint.attribute, relatedBy: constraint.relation, toItem: secondView, attribute: constraint.attribute, multiplier: constraint.multiplier, constant: constraint.constant)
        }

        NSLayoutConstraint.activate(constraints)
    }
}

struct Constraint {
    var attribute: NSLayoutConstraint.Attribute
    var relation: NSLayoutConstraint.Relation = .equal
    var constant: CGFloat = 0
    var multiplier: CGFloat = 1

    var isReversed: Bool {
        attribute == .bottom || attribute == .trailing
    }
}

