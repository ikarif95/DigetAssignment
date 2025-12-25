//
//  ButtonExtension.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import UIKit

extension UIButton {

    static func appButton( title: String,icon: String? = nil, target: Any?, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .primary
        button.layer.cornerRadius = AppLayout.cornerRadiusMedium

        // Minimum touch target
        button.heightAnchor.constraint(greaterThanOrEqualToConstant: AppLayout.minTouchTarget).isActive = true

        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .primary
        config.baseForegroundColor = .white
        config.title = title
        if let icon {
            config.image = UIImage(systemName: icon)
        }
        config.imagePadding = AppLayout.spacing8
        config.contentInsets = NSDirectionalEdgeInsets(top: AppLayout.spacing16, leading: AppLayout.spacing20, bottom: AppLayout.spacing16, trailing: AppLayout.spacing20)

        config.titleTextAttributesTransformer =
            UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = AppTypography.headline()
                return outgoing
            }
        button.configuration = config
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
}
