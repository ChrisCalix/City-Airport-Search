//
//  SearchCityCoordinator.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import Foundation

final class SearchCityCoordinator: BaseCoordinator {
    
    override func start() {
        guard let view = SearchCityViewController.instantiate() else {
            return
        }
        
    }
}
