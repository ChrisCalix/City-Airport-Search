//
//  SearchCityViewModel.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import RxCocoa

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
    
    init(input: SearchCityViewModelPresentable.Input) {
        self.input = input
        self.output = SearchCityViewModel.output(input: input)
    }
}

private extension SearchCityViewModel {
    static func output(input: SearchCityViewModelPresentable.Input) {
        return ()
    }
}
