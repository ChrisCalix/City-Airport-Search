//
//  AirportsViewModel.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import Foundation

protocol AirportsViewPresentable {
    
    typealias Output = ()
    typealias Input = ()
    
    var output: Self.Output { get }
    var input: Self.Input { get }
}

struct AirportsViewModel: AirportsViewPresentable {
    let input: Self.Input
    let output: Self.Output
    
}
