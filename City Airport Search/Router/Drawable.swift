//
//  Drawable.swift
//  City Airport Search
//
//  Created by Sonic on 19/5/23.
//

import UIKit

protocol Drawable {
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    var viewController: UIViewController? { return self }
}
