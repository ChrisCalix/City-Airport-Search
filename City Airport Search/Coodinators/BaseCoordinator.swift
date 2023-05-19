//
//  BaseCoordinator.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import Foundation

class BaseCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    var isCompleted: (() -> Void)?
    
    func start() {
        fatalError("Children  should implement 'start'.")
    }
}
