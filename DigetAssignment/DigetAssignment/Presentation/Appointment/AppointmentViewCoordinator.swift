//
//  AppointmentViewCoordinator.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import UIKit

final class AppointmentsCoordinator: Coordinator {
    let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private let appointmentRepository: AppointmentRepositoryProtocol
    private let patientId: UUID
    
    init( navigationController: UINavigationController, appointmentRepository: AppointmentRepositoryProtocol, patientId: UUID) {
        self.navigationController = navigationController
        self.appointmentRepository = appointmentRepository
        self.patientId = patientId
    }
    
    func start() {
        let useCase = GetAppointmentsUseCase(repository: appointmentRepository)
        let viewModel = AppointmentsViewModel(getAppointmentsUseCase: useCase, patientId: patientId, coordinator: self)
        let viewController = AppointmentsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showAppointmentDetail(_ appointment: Appointment) {
        let viewModel = AppointmentDetailViewModel(appointment: appointment)
        let viewController = AppointmentDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
