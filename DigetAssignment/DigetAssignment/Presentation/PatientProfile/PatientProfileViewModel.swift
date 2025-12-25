//
//  PatientProfileViewModel.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import Combine
import Foundation

final class PatientProfileViewModel {
    enum State {
        case idle
        case loading
        case loaded(Patient)
        case error(Error?)
    }
    
    @Published private(set) var state: State = .idle
    
    private let getPatientUseCase: GetPatientProfileUseCaseProtocol
    private weak var coordinator: PatientProfileCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    init(getPatientUseCase: GetPatientProfileUseCaseProtocol, coordinator: PatientProfileCoordinator?) {
        self.getPatientUseCase = getPatientUseCase
        self.coordinator = coordinator
    }
    
    func loadPatient() {
        state = .loading
        getPatientUseCase.execute(patientId: MockDataSource.shared.currentPatientId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.state = .error(error)
                }
            } receiveValue: { [weak self] patient in
                self?.state = .loaded(patient)
            }
            .store(in: &cancellables)
    }
    
    func didTapAppointments() {
        guard case .loaded(let patient) = state else { return }
        coordinator?.showAppointments(patientId: patient.id)
    }
    
    func didTapVitals() {
        guard case .loaded(let patient) = state else { return }
        coordinator?.showVitals(patientId: patient.id)
    }
    
}
