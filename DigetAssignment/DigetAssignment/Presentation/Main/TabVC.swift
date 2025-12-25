//
//  TabVC.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//


import UIKit
import Combine

final class TabBarViewController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        configureBehavior()
    }

    // MARK: - Appearance
    private func configureAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .secondaryBackground

        appearance.stackedLayoutAppearance.selected.iconColor = .primary
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.primary,
            .font: AppTypography.caption1()
        ]

        appearance.stackedLayoutAppearance.normal.iconColor = .secondaryText
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.secondaryText,
            .font: AppTypography.caption1()
        ]

        tabBar.standardAppearance = appearance

        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }

        tabBar.isTranslucent = false
    }

    // MARK: - Behavior
    private func configureBehavior() {
        delegate = self
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}
