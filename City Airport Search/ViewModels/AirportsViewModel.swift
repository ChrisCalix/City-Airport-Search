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
        models: Set<AirportModel>,
        currentLocation: Observable<(lat: Double, lon: Double)?>
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
        let sections = Observable.just(dependencies.models)
            .withLatestFrom(dependencies.currentLocation) {(models: $0, currentLocation: $1)}
            .map({ arg in
                arg.models.compactMap({
                    AirportViewModel(using: $0, currentLocation: arg.currentLocation ?? (lat: 0, lon: 0))
                })
                .sorted()
            })
            .map({ [AirportItemsSection(model: 0, items: $0)]})
            .asDriver(onErrorJustReturn: [])
        
        return (
            title: Driver.just(dependencies.title),
            airports: sections
        )
    }
}

extension AirportViewModel: Comparable {
    
    static func < (lhs: AirportViewModel, rhs: AirportViewModel) -> Bool {
        return lhs.distance ?? 0 < rhs.distance ?? 0
    }
    
    static func == (lhs: AirportViewModel, rhs: AirportViewModel) -> Bool {
        return lhs.code == rhs.code
    }
}
