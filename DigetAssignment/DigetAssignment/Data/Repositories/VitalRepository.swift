//
//  VitalRepository.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Combine
import Foundation

final class VitalRepository: VitalRepositoryProtocol {
    private let dataSource: MockDataSource
    
    init(dataSource: MockDataSource = MockDataSource.shared) {
        self.dataSource = dataSource
    }
    
    func getVitals(for patientId: UUID) -> AnyPublisher<[Vital], Error> {
        Just(dataSource.mockVitals)
            .delay(for: .milliseconds(800), scheduler: DispatchQueue.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
