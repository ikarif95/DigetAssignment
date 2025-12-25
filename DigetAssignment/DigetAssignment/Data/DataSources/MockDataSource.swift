//
//  MockDataSource.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Foundation

final class MockDataSource {

    static let shared = MockDataSource()
    
    private init() {}
    
    let currentPatientId = UUID(uuidString: "123e4567-e89b-12d3-a456-426614174000")!
    
    lazy var mockPatient: Patient = {
        Patient(
            id: currentPatientId,
            firstName: "John",
            lastName: "Doe",
            dateOfBirth: Calendar.current.date(byAdding: .year, value: -35, to: Date())!,
            gender: .male,
            bloodType: .oPositive,
            phoneNumber: "+1 (555) 123-4567",
            email: "john.doe@example.com",
            address: Address(
                street: "123 Medical Plaza",
                city: "San Francisco",
                state: "CA",
                zipCode: "94102",
                country: "USA"
            ),
            emergencyContact: EmergencyContact(
                name: "Jane Doe",
                relationship: "Spouse",
                phoneNumber: "+1 (555) 987-6543"
            )
        )
    }()
    
    lazy var mockAppointments: [Appointment] = {
        let now = Date()
        return [
            Appointment(
                id: UUID(),
                patientId: currentPatientId,
                doctorName: "Dr. Sarah Johnson",
                specialty: "Cardiology",
                date: Calendar.current.date(byAdding: .day, value: 3, to: now)!,
                duration: 3600,
                location: "Cardiology Center, Room 205",
                type: .checkup,
                status: .scheduled,
                notes: "Annual cardiac checkup"
            ),
            Appointment(
                id: UUID(),
                patientId: currentPatientId,
                doctorName: "Dr. Michael Chen",
                specialty: "General Practice",
                date: Calendar.current.date(byAdding: .day, value: 7, to: now)!,
                duration: 1800,
                location: "Main Building, Room 101",
                type: .followUp,
                status: .confirmed,
                notes: "Follow-up on recent blood work"
            ),
            Appointment(
                id: UUID(),
                patientId: currentPatientId,
                doctorName: "Dr. Emily Martinez",
                specialty: "Dermatology",
                date: Calendar.current.date(byAdding: .day, value: 14, to: now)!,
                duration: 2400,
                location: "Dermatology Clinic, Room 302",
                type: .consultation,
                status: .scheduled,
                notes: nil
            ),
            Appointment(
                id: UUID(),
                patientId: currentPatientId,
                doctorName: "Dr. Robert Brown",
                specialty: "Orthopedics",
                date: Calendar.current.date(byAdding: .day, value: -7, to: now)!,
                duration: 3600,
                location: "Orthopedic Center, Room 150",
                type: .followUp,
                status: .completed,
                notes: "Post-surgery follow-up"
            )
        ]
    }()
    
    lazy var mockVitals: [Vital] = {
        let now = Date()
        return [
            Vital(
                id: UUID(),
                patientId: currentPatientId,
                type: .heartRate,
                value: 72,
                unit: "bpm",
                measuredAt: now,
                notes: nil
            ),
            Vital(
                id: UUID(),
                patientId: currentPatientId,
                type: .bloodPressureSystolic,
                value: 118,
                unit: "mmHg",
                measuredAt: now,
                notes: nil
            ),
            Vital(
                id: UUID(),
                patientId: currentPatientId,
                type: .bloodPressureDiastolic,
                value: 76,
                unit: "mmHg",
                measuredAt: now,
                notes: nil
            ),
            Vital(
                id: UUID(),
                patientId: currentPatientId,
                type: .temperature,
                value: 36.8,
                unit: "°C",
                measuredAt: now,
                notes: nil
            ),
            Vital(
                id: UUID(),
                patientId: currentPatientId,
                type: .oxygenSaturation,
                value: 98,
                unit: "%",
                measuredAt: now,
                notes: nil
            ),
            Vital(
                id: UUID(),
                patientId: currentPatientId,
                type: .weight,
                value: 75.5,
                unit: "kg",
                measuredAt: Calendar.current.date(byAdding: .day, value: -7, to: now)!,
                notes: nil
            ),
            Vital(
                id: UUID(),
                patientId: currentPatientId,
                type: .bloodGlucose,
                value: 95,
                unit: "mg/dL",
                measuredAt: Calendar.current.date(byAdding: .hour, value: -2, to: now)!,
                notes: "Fasting"
            )
        ]
    }()
}
