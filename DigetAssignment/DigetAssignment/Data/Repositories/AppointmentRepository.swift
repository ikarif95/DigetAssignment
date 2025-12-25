//
//  AppointmentRepository.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Combine
import Foundation

final class AppointmentRepository: AppointmentRepositoryProtocol {
    private let dataSource: MockDataSource
    
    init(dataSource: MockDataSource = MockDataSource.shared) {
        self.dataSource = dataSource
    }
    
    func getAppointments(for patientId: UUID) -> AnyPublisher<[Appointment], Error> {
        Just(dataSource.mockAppointments)
            .delay(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
}
