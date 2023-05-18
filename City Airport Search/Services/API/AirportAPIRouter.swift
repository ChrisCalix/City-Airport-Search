//
//  AirportAPIRouter.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import Foundation

enum AirportAPIRouter {
    case getAirports
}

extension AirportAPIRouter: APIRouter {
    var baseUrlString: String {
        "https://gist.githubusercontent.com/tdreyno/4278655/raw/7b0762c09b519f40397e4c3e100b097d861f5588"
    }
    
    var path: String {
        switch self {
        case .getAirports:
            return "airports.json"
        }
    }
    
    func makePathComplete() -> String {
        return "\(baseUrlString)/\(path)"
    }
}
