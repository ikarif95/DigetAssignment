//
//  DateExtension.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Foundation


extension Date {
    
    var inDateTime: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: self)
    }
}
