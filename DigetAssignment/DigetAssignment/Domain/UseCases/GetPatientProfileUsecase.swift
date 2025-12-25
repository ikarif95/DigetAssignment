//
//  GetPatientProfileUsecase.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Combine
import Foundation

protocol GetPatientProfileUseCaseProtocol {
    func execute(patientId: UUID) -> AnyPublisher<Patient, Error>
}

final class GetPatientProfileUseCase: GetPatientProfileUseCaseProtocol {
    private let repository: PatientRepositoryProtocol
    
    init(repository: PatientRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(patientId: UUID) -> AnyPublisher<Patient, Error> {
        repository.getPatient(id: patientId)
    }
}
