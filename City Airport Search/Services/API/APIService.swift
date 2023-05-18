//
//  APIService.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import Foundation

protocol APIService {
    
    func request(completion: @escaping (Result<AirportsResponse, Error>) -> Void)
}
