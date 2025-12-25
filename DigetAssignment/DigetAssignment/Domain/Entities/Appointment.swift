//
//  Appointment.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Foundation

struct Appointment: Identifiable, Equatable {
    let id: UUID
    let patientId: UUID
    let doctorName: String
    let specialty: String
    let date: Date
    let duration: TimeInterval
    let location: String
    let type: AppointmentType
    let status: AppointmentStatus
    let notes: String?
    
    enum AppointmentType: String, Codable {
        case checkup = "Check-up"
        case followUp = "Follow-up"
        case consultation = "Consultation"
        case emergency = "Emergency"
        case telemedicine = "Telemedicine"
    }
    
    enum AppointmentStatus: String, Codable {
        case scheduled = "Scheduled"
        case confirmed = "Confirmed"
        case inProgress = "In Progress"
        case completed = "Completed"
        case cancelled = "Cancelled"
        case noShow = "No Show"
    }
    
    var endDate: Date {
        date.addingTimeInterval(duration)
    }
    
    var isUpcoming: Bool {
        date > Date()
    }
}
