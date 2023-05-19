//
//  AirportsViewModel.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

typealias AirportItemsSection = SectionModel<Int, AirportViewPresentable>

protocol AirportsViewPresentable {
    
    typealias Output = (
        title: Driver<String>,
        airports: Driver<[AirportItemsSection]>
    )
    typealias Input = (
        
    )
    typealias Dependencies = (
        title: String,
        models: Set<AirportModel>
    )
    typealias viewModelBuilder = (AirportsViewPresentable.Input) -> AirportsViewPresentable
    
    var output: AirportsViewPresentable.Output { get }
    var input: AirportsViewPresentable.Input { get }
}

struct AirportsViewModel: AirportsViewPresentable {
    let input: AirportsViewPresentable.Input
    let output: AirportsViewPresentable.Output
    
    init(input: AirportsViewPresentable.Input, dependencies: AirportsViewPresentable.Dependencies) {
        self.input = input
        self.output = AirportViewModel.output(dependencies)
    }
}

private extension AirportViewModel {
    static func output(_ dependencies: AirportsViewPresentable.Dependencies) -> AirportsViewPresentable.Output {
        let sections = Driver.just(dependencies.models)
            .map({$0.compactMap(AirportViewModel.init)})
            .map({ [AirportItemsSection(model: 0, items: $0)]})
        
        return (
            title: Driver.just(dependencies.title),
            airports: sections
        )
    }
}
