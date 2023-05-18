//
//  APIRouter.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import Foundation

protocol APIRouter {
    
    var baseUrlString: String { get }
    var path: String { get }
    
    func makePathComplete() -> String
}
