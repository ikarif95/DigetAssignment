//
//  Vital.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Foundation

struct Vital: Identifiable, Equatable {
    let id: UUID
    let patientId: UUID
    let type: VitalType
    let value: Double
    let unit: String
    let measuredAt: Date
    let notes: String?
    
    enum VitalType: String, Codable {
        case heartRate = "Heart Rate"
        case bloodPressureSystolic = "Blood Pressure (Systolic)"
        case bloodPressureDiastolic = "Blood Pressure (Diastolic)"
        case temperature = "Temperature"
        case oxygenSaturation = "Oxygen Saturation"
        case respiratoryRate = "Respiratory Rate"
        case weight = "Weight"
        case height = "Height"
        case bloodGlucose = "Blood Glucose"
    }
    
    var displayValue: String {
        String(format: "%.1f %@", value, unit)
    }
    
    var isNormal: Bool {
        switch type {
        case .heartRate: return value >= 60 && value <= 100
        case .bloodPressureSystolic: return value >= 90 && value <= 120
        case .bloodPressureDiastolic: return value >= 60 && value <= 80
        case .temperature: return value >= 36.1 && value <= 37.2
        case .oxygenSaturation: return value >= 95 && value <= 100
        case .respiratoryRate: return value >= 12 && value <= 20
        case .bloodGlucose: return value >= 70 && value <= 100
        default: return true
        }
    }
    
}

enum VitalMockFactory {
    
    static func mock(patientId: UUID = UUID(), type: Vital.VitalType, value: Double, measuredAt: Date = Date(), notes: String? = nil) -> Vital {
        Vital(id: UUID(), patientId: patientId, type: type, value: value, unit: type.rawValue, measuredAt: measuredAt, notes: notes)
    }
    
}
