//
//  CityViewModel.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import Foundation
import RxDataSources

typealias CityItemsSection = SectionModel<Int, CityViewPresentable>

protocol CityViewPresentable {
    var city: String { get }
    var location: String { get }
}

struct CityViewModel: CityViewPresentable {
    
    var city: String
    var location: String
}

extension CityViewModel {
    
    init(model: AirportModel) {
        city = model.city
        location = "\(model.state ?? ""), \(model.country)"
    }
}

extension CityViewModel: Equatable {
    
    static func == (lhs: CityViewModel, rhs: CityViewModel) -> Bool {
        return lhs.city == rhs.city
    }
}

extension CityViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(city)
    }
}
