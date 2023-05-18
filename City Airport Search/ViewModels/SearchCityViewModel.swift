//
//  SearchCityViewModel.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import RxCocoa
import RxSwift
import RxRelay

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
    typealias State = (airports: BehaviorRelay<Set<AirportModel>>, ())
    
    var input: SearchCityViewModelPresentable.Input
    var output: SearchCityViewModelPresentable.Ouput
    private let airportAPIService: APIService
    private let disposeBag = DisposeBag()
    private let state: State = (airports: BehaviorRelay<Set<AirportModel>>(value: []), ())
    
    init(input: SearchCityViewModelPresentable.Input, airportAPIService: APIService) {
        self.input = input
        self.output = SearchCityViewModel.output(input: input, state: state, bag: disposeBag)
        self.airportAPIService = airportAPIService
        self.process()
    }
}

private extension SearchCityViewModel {
    static func output(input: SearchCityViewModelPresentable.Input, state: State, bag: DisposeBag) {
        
        let searchTextObservable = input.searchText
            .debounce(.milliseconds(300))
            .distinctUntilChanged()
            .skip(1)
            .asObservable()
            .share(replay: 1, scope: .whileConnected)
        let airportsObservable = state.airports.skip(1).asObservable()
        
        Observable
            .combineLatest(searchTextObservable, airportsObservable)
            .map({ searchkey, airports in
                return airports.filter({ airport -> Bool in
                    !searchkey.isEmpty &&
                    airport.city.lowercased().replacingOccurrences(of: " ", with: "")
                        .hasPrefix(searchkey.lowercased())
                })
            })
            .map {
                print($0)
            }
            .subscribe()
            .disposed(by: bag)
        
        return ()
    }
    
    func process() {
        self.fetchAirports()
            .map({Set($0)})
            .map({ [state] airport in
                state.airports.accept(airport)
            })
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
