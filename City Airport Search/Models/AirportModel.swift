//
//  AirportModel.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import Foundation

typealias AirportsResponse = [AirportModel]

struct AirportModel: Codable {
    let code, lat, lon, name: String
    let city, country, woeid: String
    let tz, phone, type, email: String
    let url, icao: String
    let elev, runwayLength, state: String?
    let directFlights, carriers: String
    
    enum CodingKeys: String, CodingKey {
        case code, lat, lon, name, city, state, country, woeid, tz, phone, type, email, url
        case runwayLength = "runway_length"
        case elev, icao
        case directFlights = "direct_flights"
        case carriers
    }
}

extension AirportModel: Equatable {
    
    static func == (lhs: AirportModel, rhs: AirportModel) -> Bool {
        return lhs.code == rhs.code
    }
}

extension AirportModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }
}
