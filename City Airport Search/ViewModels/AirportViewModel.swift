//
//  AirportViewModel.swift
//  City Airport Search
//
//  Created by Sonic on 19/5/23.
//

import Foundation

protocol AirportViewPresentable {
    var name: String { get }
    var code: String { get }
    var address: String { get }
    var distance: Double? { get }
    var formattedDistance: String { get }
    var runwayLength: String { get }
    var location: (lat: String, lon: String) { get }
    
}

struct AirportViewModel : AirportViewPresentable{
    var formattedDistance: String {
        return "\(distance?.rounded(.toNearestOrEven) ?? 0 / 1000) Km"
    }
    
    var name: String
    var code: String
    var address: String
    var distance: Double?
    var runwayLength: String
    var location: (lat: String, lon: String)
    
}

extension AirportViewModel {
    init(using model: AirportModel) {
        name = model.name
        code = model.code
        address = "\(model.state ?? ""), \(model.country)"
        runwayLength = "Runway Lungth: \(model.runwayLength ?? "NA")"
        location = (lat: model.lat, lon: model.lon)
        // TODO: Distaning calculation from current location to airport
        distance = 0
    }
}
