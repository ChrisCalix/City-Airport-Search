//
//  SearchCityCoordinator.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import UIKit

final class SearchCityCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        guard let view = SearchCityViewController.instantiate() else {
            return
        }
        view.viewModilBuilder = {
            SearchCityViewModel(input: $0, airportAPIService: AirportAPIService(router: AirportAPIRouter.getAirports))
        }
        navigationController.pushViewController(view, animated: true)
    }
}
