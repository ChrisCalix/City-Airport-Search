//
//  AirportsCoordinator.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import UIKit

final class AirportsCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController
    private let models: Set<AirportModel>
    
    init(models: Set<AirportModel>,  navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.models = models
    }
    
    override func start() {
        guard let view = AirportsViewController.instantiate() else { return }
        view.viewModelBuilder = { [models] in
            let title = models.first?.city ?? ""
            return AirportsViewModel(input: $0, dependencies: (title: title, models: models))
        }
        self.navigationController.pushViewController(view, animated: true)
    }
}
