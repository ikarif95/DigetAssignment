//
//  Patient.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Foundation

struct Patient: Identifiable, Equatable {
    let id: UUID
    let firstName: String
    let lastName: String
    let dateOfBirth: Date
    let gender: Gender
    let bloodType: BloodType
    let phoneNumber: String
    let email: String
    let address: Address
    let emergencyContact: EmergencyContact
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    var age: Int {
        Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date()).year ?? 0
    }
    
    enum Gender: String, Codable {
        case male = "Male"
        case female = "Female"
        case other = "Other"
    }
    
    enum BloodType: String, Codable {
        case aPositive = "A+"
        case aNegative = "A-"
        case bPositive = "B+"
        case bNegative = "B-"
        case abPositive = "AB+"
        case abNegative = "AB-"
        case oPositive = "O+"
        case oNegative = "O-"
    }
}

struct Address: Equatable, Codable {
    let street: String
    let city: String
    let state: String
    let zipCode: String
    let country: String
}

struct EmergencyContact: Equatable, Codable {
    let name: String
    let relationship: String
    let phoneNumber: String
}
