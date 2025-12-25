//
//  VitalRepositoryProtocol.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Combine
import Foundation

protocol VitalRepositoryProtocol {
    func getVitals(for patientId: UUID) -> AnyPublisher<[Vital], Error>
}
