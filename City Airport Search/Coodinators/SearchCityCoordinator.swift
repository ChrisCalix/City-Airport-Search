//
//  SearchCityCoordinator.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchCityCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController
    private let bag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        guard let view = SearchCityViewController.instantiate() else {
            return
        }
        view.viewModelBuilder = { [bag] in
            var viewModel = SearchCityViewModel(input: $0, airportAPIService: AirportAPIService(router: AirportAPIRouter.getAirports))
            viewModel.router.citySelected
                .map({[weak self] in
                    self?.showAirports(using: $0)
                })
            .drive()
            .disposed(by: bag)
            return viewModel
        }
        navigationController.pushViewController(view, animated: true)
    }
}

extension SearchCityCoordinator {
    
    func showAirports(using models: Set<AirportModel>) {
        let airportsCoordinator = AirportsCoordinator(models: models, navigationController: self.navigationController)
        self.add(coordinator: airportsCoordinator)
        
        airportsCoordinator.start()
    }
}
