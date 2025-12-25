//
//  AppointmentRepositoryProtocol.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Combine
import Foundation

protocol AppointmentRepositoryProtocol {
    func getAppointments(for patientId: UUID) -> AnyPublisher<[Appointment], Error>
}
