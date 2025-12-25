//
//  UserDefaultExtension.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/25/25.
//

import Foundation

extension UserDefaults {

    private enum Keys {
        static let userName = "userName"
    }

    var isDarkMode: Bool {
        get {
            return bool(forKey: "isDarkMode")
        } set {
            set(newValue, forKey: "isDarkMode")
        }
    }
}
