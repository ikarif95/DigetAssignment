//
//  AppointmentViewModel.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Combine
import Foundation

class AppointmentsViewModel {
    enum State {
        case idle
        case loading
        case loaded([Appointment])
        case error(Error?)
    }
    
    @Published private(set) var state: State = .idle
    
    private let getAppointmentsUseCase: GetAppointmentsUseCaseProtocol
    private let patientId: UUID
    private weak var coordinator: AppointmentsCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    
    init(getAppointmentsUseCase: GetAppointmentsUseCaseProtocol, patientId: UUID, coordinator: AppointmentsCoordinator) {
        self.getAppointmentsUseCase = getAppointmentsUseCase
        self.patientId = patientId
        self.coordinator = coordinator
    }
    
    func loadAppointments() {
        state = .loading
        
        getAppointmentsUseCase.execute(patientId: patientId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.state = .error(error)
                }
            } receiveValue: { [weak self] appointments in
                self?.state = .loaded(appointments.sorted { $0.date < $1.date })
            }
            .store(in: &cancellables)
    }
    
    func didSelectAppointment(_ appointment: Appointment) {
        coordinator?.showAppointmentDetail(appointment)
    }
}
