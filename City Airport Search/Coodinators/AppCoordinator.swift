//
//  AppCoordinator.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow?
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        let navigationBar = navigationController.navigationBar
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.primaryColor
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        navigationBar.isTranslucent = false
        return navigationController
    }()
    
    init(window: UIWindow?){
        self.window = window
    }
    
    override func start() {
        let router = Router(navigationController: self.navigationController)
        let searchCityCoordinator = SearchCityCoordinator(router: router)
        self.add(coordinator: searchCityCoordinator)
        
        searchCityCoordinator.isCompleted = { [weak self, weak searchCityCoordinator] in
            guard let searchCityCoordinator else { return }
            self?.remove(coordinator: searchCityCoordinator)
        }
        
        searchCityCoordinator.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
