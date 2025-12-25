//
//  GetVitalsUseCase.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Combine
import Foundation

protocol GetVitalsUseCaseProtocol {
    func execute(patientId: UUID) -> AnyPublisher<[Vital], Error>
}

final class GetVitalsUseCase: GetVitalsUseCaseProtocol {
    private let repository: VitalRepositoryProtocol
    
    init(repository: VitalRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(patientId: UUID) -> AnyPublisher<[Vital], Error> {
        repository.getVitals(for: patientId)
    }
   
}
