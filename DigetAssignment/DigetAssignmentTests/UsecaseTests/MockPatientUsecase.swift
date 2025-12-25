//
//  MockPatientUsecase .swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/25/25.
//

import Foundation
import Combine
@testable import DigetAssignment

struct TestDataFactory {
    static func createMockPatient(
        id: UUID = UUID(),
        firstName: String = "John",
        lastName: String = "Doe"
    ) -> Patient {
        Patient(
            id: id,
            firstName: firstName,
            lastName: lastName,
            dateOfBirth: Calendar.current.date(byAdding: .year, value: -35, to: Date())!,
            gender: .male,
            bloodType: .oPositive,
            phoneNumber: "+1 (555) 123-4567",
            email: "john.doe@test.com",
            address: Address(
                street: "123 Test St",
                city: "Test City",
                state: "TC",
                zipCode: "12345",
                country: "USA"
            ),
            emergencyContact: EmergencyContact(
                name: "Jane Doe",
                relationship: "Spouse",
                phoneNumber: "+1 (555) 987-6543"
            )
        )
    }
    
}

final class MockGetPatientProfileUseCase: GetPatientProfileUseCaseProtocol {
    var executeCalled = false
    var executeCallCount = 0
    var executeResult: Result<Patient, Error>!
    var capturedPatientId: UUID?
    
    func execute(patientId: UUID) -> AnyPublisher<Patient, Error> {
        executeCalled = true
        executeCallCount += 1
        capturedPatientId = patientId
        
        return executeResult.publisher.eraseToAnyPublisher()
    }
}
