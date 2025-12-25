//
//  VitalCoordinator.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

// MARK: - 29. Presentation/Vitals/VitalsCoordinator.swift

import UIKit

final class VitalsCoordinator: Coordinator {
    let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private let vitalRepository: VitalRepositoryProtocol
    private let patientId: UUID
    
    init(navigationController: UINavigationController, vitalRepository: VitalRepositoryProtocol, patientId: UUID) {
        self.navigationController = navigationController
        self.vitalRepository = vitalRepository
        self.patientId = patientId
    }
    
    func start() {
        let useCase = GetVitalsUseCase(repository: vitalRepository)
        let viewModel = VitalsViewModel(getVitalsUseCase: useCase, patientId: patientId)
        let viewController = VitalsVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
