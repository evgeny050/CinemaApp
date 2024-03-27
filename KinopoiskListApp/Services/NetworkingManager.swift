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
      "X-API-KEY": "0DRDXYH-D2CM4R4-GEY083Z-N090K66"
    ]
    
    private let decoder = JSONDecoder()
    
    private init() {}
    
    private func createURL() -> String {
        return ""
    }
    
    private func sortPersonsByBirthday() {
        
    }
    
    // MARK: - Alamofire request
    func fetchData(completion: @escaping(Result<KPSectionEnum, AFError>) -> Void) {
        var kpSectionEnum: Result<KPSectionEnum, AFError>!
        let group = DispatchGroup()
        
        group.enter()
        print("Fetching collections started")
        requestAPI(with: EnumLinks.getCollectionsUrl.rawValue) { result in
            switch result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                print("Fetching collections failed")
                print(error)
            }
            group.leave()
        }
        
        group.enter()
        print("Fetching persons started")
        requestAPI(with: "https://api.kinopoisk.dev/v1.4/person?page=1&limit=250&selectFields=name&selectFields=photo" +
                   "&selectFields=birthday&notNullFields=photo&notNullFields=birthday") { result in
            switch result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                print("Fetching collections failed")
                print(error)
            }
            group.leave()
        }
        
        group.notify(queue: .main) { // once all the groups perform leave(), notify will be triggered and you can perform the needed actions
            completion(kpSectionEnum)
        }
        
//        AF.request(EnumLinks.getCollectionsUrl.rawValue, headers: headers)
//            .validate()
//            .responseDecodable(of: KPSectionEnum.self, decoder: decoder) { dataResponse in
//                switch dataResponse.result {
//                case .success(let value):
//                    completion(.success(value))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
    }
    
    func requestAPI(with url: String, completion: @escaping(Result<KPSectionEnum, AFError>) -> Void) {
        AF.request(url, headers: headers)
            .validate()
            .responseDecodable(of: KPSectionEnum.self, decoder: decoder) { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchImageData(from url: String) -> Data? {
        guard let url = URL(string: url) else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return imageData
    }
    
}
