//
//  PatientProfileCoordinator.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import UIKit

protocol PatientProfileCoordinatorDelegate: AnyObject {
    func didFinish()
}

final class PatientProfileCoordinator: Coordinator {
    
    // MARK: - Coordinator Protocol Properties
    let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var delegate: PatientProfileCoordinatorDelegate?
    
    // MARK: - Dependencies (Injected)
    private let patientRepository: PatientRepositoryProtocol
    private let appointmentRepository: AppointmentRepositoryProtocol
    private let vitalRepository: VitalRepositoryProtocol
    
    // MARK: - Initializer
    init(navigationController: UINavigationController, patientRepository: PatientRepositoryProtocol, appointmentRepository: AppointmentRepositoryProtocol, vitalRepository: VitalRepositoryProtocol) {
        self.navigationController = navigationController
        self.patientRepository = patientRepository
        self.appointmentRepository = appointmentRepository
        self.vitalRepository = vitalRepository
    }
    
    // MARK: - Coordinator Protocol Methods
    func start() {
        let getPatientUseCase = GetPatientProfileUseCase(repository: patientRepository)
        let viewModel = PatientProfileViewModel(getPatientUseCase: getPatientUseCase, coordinator: self)
        let viewController = PatientProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Navigation Methods
    func showAppointments(patientId: UUID) {
        let appointmentsCoordinator = AppointmentsCoordinator(navigationController: navigationController, appointmentRepository: appointmentRepository, patientId: patientId)
        addChildCoordinator(appointmentsCoordinator)
        appointmentsCoordinator.start()
    }
   
    func showVitals(patientId: UUID) {
        let vitalsCoordinator = VitalsCoordinator(navigationController: navigationController, vitalRepository: vitalRepository, patientId: patientId)
        addChildCoordinator(vitalsCoordinator)
        vitalsCoordinator.start()
    }
    
    private func finish() {
        delegate?.didFinish()
    }
}
