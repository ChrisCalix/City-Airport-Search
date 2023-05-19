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
    private let router: Routing
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
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
        
        router.push(view, isAnimated: true, onNavigationBack: isCompleted)
    }
}

extension SearchCityCoordinator {
    
    func showAirports(using models: Set<AirportModel>) {
        let airportsCoordinator = AirportsCoordinator(models: models, rooter: self.router)
        self.add(coordinator: airportsCoordinator)
        airportsCoordinator.isCompleted = { [weak self, weak airportsCoordinator] in
            guard let airportsCoordinator else { return }
            self?.remove(coordinator: airportsCoordinator)
        }
        airportsCoordinator.start()
    }
}
