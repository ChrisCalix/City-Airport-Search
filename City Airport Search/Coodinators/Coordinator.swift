//
//  Coordinator.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    func add(coordinator: Coordinator) {
        childCoordinator.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) {
        childCoordinator = childCoordinator.filter({ $0 !== coordinator})
    }
}
