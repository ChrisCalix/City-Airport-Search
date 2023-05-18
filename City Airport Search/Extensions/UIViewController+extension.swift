//
//  Storyboardable.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import UIKit

extension UIViewController  {
    static func instantiate() -> Self? {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as? Self
    }
}
