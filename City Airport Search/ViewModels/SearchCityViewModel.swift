//
//  SearchCityViewModel.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import RxCocoa
import RxSwift
import RxRelay
import RxDataSources

protocol SearchCityViewModelPresentable {
    typealias Input = (
        searchText: Driver<String>,
        citySelect: Driver<CityViewModel>
    )
    typealias Ouput = (
        cities: Driver<[CityItemsSection]>, ()
    )
    typealias ViewModelBuilder = (SearchCityViewModelPresentable.Input) -> SearchCityViewModelPresentable
    
    var input: SearchCityViewModelPresentable.Input { get }
    var output: SearchCityViewModelPresentable.Ouput? { get }
}

struct SearchCityViewModel: SearchCityViewModelPresentable {
    typealias State = (airports: BehaviorRelay<Set<AirportModel>>, ())
    typealias RoutingAction = (citySelectedRelay: PublishRelay<Set<AirportModel>>, ())
    typealias Routing = (citySelected: Driver<Set<AirportModel>>, ())
    
    let input: SearchCityViewModelPresentable.Input
    let output: SearchCityViewModelPresentable.Ouput?
    
    private let airportAPIService: APIService
    private let bag = DisposeBag()
    private let state: State = (airports: BehaviorRelay<Set<AirportModel>>(value: []), ())
    private let routingAction: RoutingAction = (citySelectedRelay: PublishRelay(), ())
    
    lazy var router = (citySelected: routingAction.citySelectedRelay.asDriver(onErrorDriveWith: .empty()), ())
    
    init(input: SearchCityViewModelPresentable.Input, airportAPIService: APIService) {
        self.input = input
        self.output = SearchCityViewModel.output(input: input, state: state)
        self.airportAPIService = airportAPIService
        self.process()
    }
}

private extension SearchCityViewModel {
    static func output(input: SearchCityViewModelPresentable.Input,
                       state: State) -> SearchCityViewModelPresentable.Ouput {
        
        let searchTextObservable = input.searchText
            .debounce(.milliseconds(300))
            .distinctUntilChanged()
            .skip(1)
            .asObservable()
            .share(replay: 1, scope: .whileConnected)
        let airportsObservable = state.airports
            .distinctUntilChanged()
            .skip(1)
            .asObservable()
            .share(replay: 1, scope: .whileConnected)
        
        let sections = Observable
            .combineLatest(searchTextObservable, airportsObservable)
            .map({ searchkey, airports in
                return airports.filter({ airport -> Bool in
                    !searchkey.isEmpty && airport.city.lowercased().replacingOccurrences(of: " ", with: "")
                        .hasPrefix(searchkey.lowercased())
                })
            })
            .map({
                SearchCityViewModel.uniqueElementsFrom(array: $0.compactMap({
                    CityViewModel(model: $0)
                }))
            })
            .map({ [CityItemsSection(model: 0, items: $0)] })
            .asDriver(onErrorJustReturn: [])
        
        return (
            cities: sections, ()
        )
    }
    
    mutating func process() {
        self.fetchAirports()
            .map({Set($0)})
            .map({ [state] airport in
                state.airports.accept(airport)
            })
            .subscribe()
            .disposed(by: bag)
        
        self.input.citySelect
            .map({$0.city})
            .withLatestFrom(state.airports.asDriver()) { ($0, $1)}
            .map { city, airports in
                airports.filter({ $0.city == city})
            }
            .map({ [routingAction] in
                routingAction.citySelectedRelay.accept($0)
            })
            .drive()
            .disposed(by: bag)
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

private extension SearchCityViewModel {
    
    static func uniqueElementsFrom(array: [CityViewModel]) -> [CityViewModel] {
        var set = Set<CityViewModel>()
        let result = array.filter {
            guard !set.contains($0) else {
                return false
            }
            set.insert($0)
            return true
        }
        return result
    }
}
