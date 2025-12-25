//
//  Typography.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import UIKit

enum AppTypography {
    static func largeTitle(weight: UIFont.Weight = .bold) -> UIFont {
        UIFont.systemFont(ofSize: 34, weight: weight)
    }
    
    static func title1(weight: UIFont.Weight = .bold) -> UIFont {
        UIFont.systemFont(ofSize: 28, weight: weight)
    }
    
    static func title2(weight: UIFont.Weight = .semibold) -> UIFont {
        UIFont.systemFont(ofSize: 22, weight: weight)
    }
    
    static func title3(weight: UIFont.Weight = .semibold) -> UIFont {
        UIFont.systemFont(ofSize: 20, weight: weight)
    }
    
    static func headline(weight: UIFont.Weight = .semibold) -> UIFont {
        UIFont.systemFont(ofSize: 17, weight: weight)
    }
    
    static func body(weight: UIFont.Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 17, weight: weight)
    }
    
    static func callout(weight: UIFont.Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 16, weight: weight)
    }
    
    static func subheadline(weight: UIFont.Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 15, weight: weight)
    }
    
    static func footnote(weight: UIFont.Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 13, weight: weight)
    }
    
    static func caption1(weight: UIFont.Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 12, weight: weight)
    }
    
    static func caption2(weight: UIFont.Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 11, weight: weight)
    }
}
