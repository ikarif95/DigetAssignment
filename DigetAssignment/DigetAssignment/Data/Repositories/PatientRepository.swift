//
//  PatientRepository.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Combine
import Foundation

final class PatientRepository: PatientRepositoryProtocol {
    private let dataSource: MockDataSource
    
    init(dataSource: MockDataSource = MockDataSource.shared) {
        self.dataSource = dataSource
    }
    
    func getPatient(id: UUID) -> AnyPublisher<Patient, Error> {
        Just(dataSource.mockPatient)
            .delay(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getCurrentPatient() -> AnyPublisher<Patient, Error> {
        getPatient(id: dataSource.currentPatientId)
    }
}
