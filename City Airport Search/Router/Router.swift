//
//  Router.swift
//  City Airport Search
//
//  Created by Sonic on 19/5/23.
//

import UIKit

final class Router: NSObject {
    
    private let navigationController: UINavigationController
    private var closures: [String: NavigationBackClosure] = [:]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }
}

extension Router: Routing {
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigationBack closure: NavigationBackClosure?) {
        guard let viewController =  drawable.viewController else { return }
        
        if let closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        navigationController.pushViewController(viewController, animated: isAnimated)
    }
    
    func pop(_isAnimated: Bool) {
        navigationController.popViewController(animated: _isAnimated)
    }
    
    func executeClosure(_ viewController: UIViewController) {
        guard let closure = closures.removeValue(forKey: viewController.description) else { return }
        closure()
    }
}

extension Router: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from),
        !navigationController.viewControllers.contains(previousController) else { return }
        executeClosure(previousController)
    }
}
