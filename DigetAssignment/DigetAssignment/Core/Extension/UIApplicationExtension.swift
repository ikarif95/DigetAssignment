//
//  UIApplicationExtension.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import UIKit

extension UIApplication {

    var firstWindow: UIWindow? {
        if #available(iOS 15.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                    return window
            } else {
                return nil
            }
        } else {
            return UIApplication.shared.windows.first{$0.isKeyWindow}
        }
    }


}
