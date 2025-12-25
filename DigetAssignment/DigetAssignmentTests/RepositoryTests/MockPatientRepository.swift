//
//  MockPatientRepository.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/25/25.
//

import Foundation
import Combine

final class MockPatientRepository: PatientRepositoryProtocol {
    var getPatientCalled = false
    var getPatientCallCount = 0
    var getPatientResult: Result<Patient, Error>!
    var capturedPatientId: UUID?
    
    func getPatient(id: UUID) -> AnyPublisher<Patient, Error> {
        getPatientCalled = true
        getPatientCallCount += 1
        capturedPatientId = id
        
        return result.publisher.eraseToAnyPublisher()
    }
    
    func getCurrentPatient() -> AnyPublisher<Patient, Error> {
        return getPatient(id: UUID())
    }
    
    private var result: Result<Patient, Error> {
        getPatientResult
    }
}
