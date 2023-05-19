//
//  RouterProtocol.swift
//  City Airport Search
//
//  Created by Sonic on 19/5/23.
//

import Foundation

typealias NavigationBackClosure = (() -> Void)

protocol Routing {
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigationBack: NavigationBackClosure?)
    func pop(_isAnimated: Bool)
}
