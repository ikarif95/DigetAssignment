//
//  MockGetVitalsUseCase.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/25/25.
//

import Foundation
import Combine
@testable import DigetAssignment



final class MockGetVitalsUseCase: GetVitalsUseCaseProtocol {

    var result: Result<[Vital], Error> = .success([])

    func execute(patientId: UUID) -> AnyPublisher<[Vital], Error> {
        result.publisher.eraseToAnyPublisher()
    }
}
