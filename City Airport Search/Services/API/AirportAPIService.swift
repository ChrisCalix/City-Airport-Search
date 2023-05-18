//
//  AirportAPIService.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import Foundation

struct AirportAPIService: APIService {
    let router: APIRouter
    
    func request(completion: @escaping (Result<AirportsResponse, Error>) -> Void) {
        guard let url = URL(string: router.makePathComplete()) else {
            completion(.failure(CustomError.error(message: "UrlError")))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                completion(.failure(CustomError.error(message: "response Error from server")))
                return
            }
            guard let airports = try? JSONDecoder().decode(AirportsResponse.self, from: data) else {
                completion(.failure(CustomError.error(message: "parse Error")))
                return
            }
            completion(.success(airports))
        }.resume()
    }
}
