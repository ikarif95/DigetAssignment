//
//  PatientRepositoryProtocol.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Combine
import Foundation

protocol PatientRepositoryProtocol {
    func getPatient(id: UUID) -> AnyPublisher<Patient, Error>
    func getCurrentPatient() -> AnyPublisher<Patient, Error>
}
