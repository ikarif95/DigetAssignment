//
//  AppCoordinator.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//


import UIKit

final class AppCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private let patientRepository: PatientRepositoryProtocol
    private let appointmentRepository: AppointmentRepositoryProtocol
    private let vitalRepository: VitalRepositoryProtocol
    
    init(navigationController: UINavigationController, patientRepository: PatientRepositoryProtocol, appointmentRepository: AppointmentRepositoryProtocol, vitalRepository: VitalRepositoryProtocol) {
        self.navigationController = navigationController
        self.patientRepository = patientRepository
        self.appointmentRepository = appointmentRepository
        self.vitalRepository = vitalRepository
    }
    
    func start() {
        showTabBar()
    }
    
    private func showTabBar() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController, patientRepository: patientRepository, appointmentRepository: appointmentRepository, vitalRepository: vitalRepository)
        addChildCoordinator(tabBarCoordinator)
        tabBarCoordinator.start()
    }
}
