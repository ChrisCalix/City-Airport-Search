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
        return navigationController
    }()
    
    init(window: UIWindow?){
        self.window = window
    }
    
    override func start() {
        let searchCityCoordinator = SearchCityCoordinator(navigationController: navigationController)
        self.add(coordinator: searchCityCoordinator)
        searchCityCoordinator.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
