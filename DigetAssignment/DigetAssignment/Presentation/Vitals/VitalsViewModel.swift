//
//  VitalsViewModel.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

// MARK: - 30. Presentation/Vitals/VitalsViewModel.swift

import Combine
import Foundation

final class VitalsViewModel {
    enum State {
        case idle
        case loading
        case loaded([Vital])
        case error(Error?)
    }
    
    @Published private(set) var state: State = .idle
    
    private let getVitalsUseCase: GetVitalsUseCaseProtocol
    private let patientId: UUID
    private var cancellables = Set<AnyCancellable>()
    
    init(getVitalsUseCase: GetVitalsUseCaseProtocol, patientId: UUID) {
        self.getVitalsUseCase = getVitalsUseCase
        self.patientId = patientId
    }
    
    func loadVitals() {
        state = .loading
        
        getVitalsUseCase.execute(patientId: patientId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.state = .error(error)
                }
            } receiveValue: { [weak self] vitals in
                self?.state = .loaded(vitals)
            }
            .store(in: &cancellables)
    }
}
