//
//  SearchCityViewModel.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import RxCocoa
import RxSwift

protocol SearchCityViewModelPresentable {
    typealias Input = (
        searchText: Driver<String>, ()
    )
    typealias Ouput = ()
    typealias ViewModelBuilder = (SearchCityViewModelPresentable.Input) -> SearchCityViewModelPresentable
    
    var input: SearchCityViewModelPresentable.Input { get }
    var output: SearchCityViewModelPresentable.Ouput { get }
}

final class SearchCityViewModel: SearchCityViewModelPresentable {
    var input: SearchCityViewModelPresentable.Input
    var output: SearchCityViewModelPresentable.Ouput
    private let airportAPIService: APIService
    private let disposeBag = DisposeBag()
    
    init(input: SearchCityViewModelPresentable.Input, airportAPIService: APIService) {
        self.input = input
        self.output = SearchCityViewModel.output(input: input)
        self.airportAPIService = airportAPIService
        self.process()
    }
}

private extension SearchCityViewModel {
    static func output(input: SearchCityViewModelPresentable.Input) {
        return ()
    }
    
    func process() {
        self.fetchAirports()
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func fetchAirports() -> Single<AirportsResponse> {
        return Single.create { (single) -> Disposable in
            self.airportAPIService.request (completion: { result in
                switch result {
                case let .success( airports):
                    single(.success(airports))
                case let .failure(error):
                    single(.failure(error))
                }
            })
            return Disposables.create()
        }
    }
}
