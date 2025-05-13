//
//  UIView+Constraint.swift
//  tymex-test
//
//  Created by Hai Nguyen on 10/5/25.
//

import UIKit

extension UIView {
    func pinToEdges(of superview: UIView, with padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: padding.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding.right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding.bottom)
        ])
    }

    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            NSLayoutConstraint.activate([
                centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                centerYAnchor.constraint(equalTo: superview.centerYAnchor)
            ])
            if size != .zero {
                setDimensions(width: size.width, height: size.height)
            }
        }
    }

    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }


    @discardableResult
    func anchor(
        top: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 0,
        leading: NSLayoutXAxisAnchor? = nil, leadingConstant: CGFloat = 0,
        trailing: NSLayoutXAxisAnchor? = nil, trailingConstant: CGFloat = 0,
        bottom: NSLayoutYAxisAnchor? = nil, bottomConstant: CGFloat = 0,
        widthConstant: CGFloat? = nil,
        heightConstant: CGFloat? = nil
    ) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()

        if let top = top {
            constraints.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }

        if let leading = leading {
            constraints.append(leadingAnchor.constraint(equalTo: leading, constant: leadingConstant))
        }

        if let trailing = trailing {
            constraints.append(trailingAnchor.constraint(equalTo: trailing, constant: -trailingConstant)) // Note: -trailing
        }

        if let bottom = bottom {
            constraints.append(bottomAnchor.constraint(lessThanOrEqualTo: bottom, constant: -bottomConstant)) // Note: lessThanOrEqual
        }

        if let width = widthConstant {
            constraints.append(widthAnchor.constraint(equalToConstant: width))
        }

        if let height = heightConstant {
            constraints.append(heightAnchor.constraint(equalToConstant: height))
        }


        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    func addShadow(radius: CGFloat = 4, opacity: Float = 0.2, offset: CGSize = .zero, color: UIColor = .black) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }


}
