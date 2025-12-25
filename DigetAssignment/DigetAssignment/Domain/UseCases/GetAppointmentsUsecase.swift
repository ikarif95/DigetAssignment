//
//  GetAppointmentsUsecase.swift.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Combine
import Foundation

protocol GetAppointmentsUseCaseProtocol {
    func execute(patientId: UUID) -> AnyPublisher<[Appointment], Error>
}

final class GetAppointmentsUseCase: GetAppointmentsUseCaseProtocol {
    private let repository: AppointmentRepositoryProtocol
    
    init(repository: AppointmentRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(patientId: UUID) -> AnyPublisher<[Appointment], Error> {
        repository.getAppointments(for: patientId)
    }
    
}
