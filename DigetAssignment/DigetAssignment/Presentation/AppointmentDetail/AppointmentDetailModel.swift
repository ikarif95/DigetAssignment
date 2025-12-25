//
//  AppointmentDetailModel.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Combine

final class AppointmentDetailViewModel {
    @Published private(set) var appointment: Appointment
    
    init(appointment: Appointment) {
        self.appointment = appointment
    }
}
