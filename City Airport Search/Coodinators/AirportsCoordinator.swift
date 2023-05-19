//
//  AirportsCoordinator.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import UIKit

final class AirportsCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {    
        guard let view = AirportsViewController.instantiate() else { return }
        self.navigationController.pushViewController(view, animated: true)
    }
}
