//
//  TabBarCoordinator.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import UIKit

/// Main coordinator that manages the TabBar and all tab coordinators
final class TabBarCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    // Dependencies
    private let patientRepository: PatientRepositoryProtocol
    private let appointmentRepository: AppointmentRepositoryProtocol
    private let vitalRepository: VitalRepositoryProtocol
    
    // Tab Bar Controller
    private var tabBarController: UITabBarController?
    
    // MARK: - Initialization
    
    init(
        navigationController: UINavigationController,
        patientRepository: PatientRepositoryProtocol,
        appointmentRepository: AppointmentRepositoryProtocol,
        vitalRepository: VitalRepositoryProtocol
    ) {
        self.navigationController = navigationController
        self.patientRepository = patientRepository
        self.appointmentRepository = appointmentRepository
        self.vitalRepository = vitalRepository
    }
    
    // MARK: - Coordinator Protocol
    
    func start() {
        let tabBarController = createTabBarController()
        self.tabBarController = tabBarController
        
        // Hide the main navigation bar since each tab has its own
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    // MARK: - Private Methods
    
    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        configureTabBarAppearance(tabBarController)
        let patientTab = createPatientProfileTab()
        let appointmentsTab = createAppointmentsTab()
        let vitalsTab = createVitalsTab()
        tabBarController.viewControllers = [
            patientTab,
            appointmentsTab,
            vitalsTab
        ]
        tabBarController.selectedIndex = 0
        return tabBarController
    }
    
    private func configureTabBarAppearance(_ tabBarController: UITabBarController) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .secondaryBackground
        tabBarController.tabBar.tintColor = .primary
        tabBarController.tabBar.unselectedItemTintColor = .secondaryText
        tabBarController.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBarController.tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func createPatientProfileTab() -> UINavigationController {
        let navController = UINavigationController()
        let coordinator = PatientProfileCoordinator(navigationController: navController, patientRepository: patientRepository, appointmentRepository: appointmentRepository, vitalRepository: vitalRepository)
        addChildCoordinator(coordinator)
        coordinator.start()
        navController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage.SFSymbol.personCircle, selectedImage: UIImage.SFSymbol.personCircleFill)
        
        return navController
    }
    
    private func createAppointmentsTab() -> UINavigationController {
        let navController = UINavigationController()
        let coordinator = AppointmentsCoordinator(navigationController: navController,appointmentRepository: appointmentRepository,patientId: MockDataSource.shared.currentPatientId)
        addChildCoordinator(coordinator)
        coordinator.start()
        navController.tabBarItem = UITabBarItem(title: "Appointments", image: UIImage.SFSymbol.calendar, selectedImage: UIImage.SFSymbol.calendarBadgeClock)
        return navController
    }
    
    private func createVitalsTab() -> UINavigationController {
        let navController = UINavigationController()
        let coordinator = VitalsCoordinator(navigationController: navController, vitalRepository: vitalRepository, patientId: MockDataSource.shared.currentPatientId)
        addChildCoordinator(coordinator)
        coordinator.start()
        navController.tabBarItem = UITabBarItem(title: "Vitals", image: UIImage.SFSymbol.heartTextSquare, selectedImage: UIImage.SFSymbol.heartTextSquareFill)
        return navController
    }
    
}
