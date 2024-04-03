//
//  NetworkingService.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 17.03.2024.
//

import Foundation
import Alamofire
import UIKit

class NetworkingManager {
    static let shared = NetworkingManager()
    
    private let headers: HTTPHeaders = [
      "accept": "application/json",
      "X-API-KEY": "H2BEHR2-ZP9MHW2-Q168Q5V-ARA0EGX"//"H2BEHR2-ZP9MHW2-Q168Q5V-ARA0EGX"//"0DRDXYH-D2CM4R4-GEY083Z-N090K66"
    ]
    
    private let decoder = JSONDecoder()
    
    private init() {}
    
    private func createURL() -> String {
        return ""
    }
    
    // MARK: - Alamofire request
    func fetchData<T: Decodable>(type: T.Type, url: String, completion: @escaping(Result<[T], AFError>) -> Void) {
        guard let url = URL(string: url) else { return }
        AF.request(url, headers: headers)
            .validate()
            .responseDecodable(of: KPSection.self, decoder: decoder) { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    switch type {
                    case is KPCollection.Type:
                        guard let kpCollections = value.items.collections else { return }
                        completion(.success((kpCollections as? [T])!))
                    case is Movie.Type:
                        guard let movies = value.items.movies else { return }
                        completion(.success((movies as? [T])!))
                    default:
                        guard let persons = value.items.persons else { return }
                        completion(.success((persons as? [T])!))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
