//
//  SceneDelegate.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let patientRepository = PatientRepository()
        let appointmentRepository = AppointmentRepository()
        let vitalRepository = VitalRepository()
        
        let appCoordinator = AppCoordinator(navigationController: navigationController, patientRepository: patientRepository, appointmentRepository: appointmentRepository, vitalRepository: vitalRepository)
        self.appCoordinator = appCoordinator
        appCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        self.window?.overrideUserInterfaceStyle = UserDefaults.standard.isDarkMode ? .dark : .light
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    


}

