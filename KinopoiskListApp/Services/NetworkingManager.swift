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
    
    // MARK: - URLSession with GCD
//    func fetchData(completion: @escaping(Result<Data, NetworkingError>) -> Void) {
//        guard let url = URL(string: EnumLinks.allMoviesByFilterParamsUrl.rawValue) else {
//            completion(.failure(.invalidURL))
//            print("invalidURL")
//            return
//        }
//        
//        let request = NSMutableURLRequest(url: url,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = [
//            "accept": "application/json",
//            "X-API-KEY": "0DRDXYH-D2CM4R4-GEY083Z-N090K66"
//          ]
//
//        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
//            
//            
//        }.resume()
//    }
    
    // MARK: - Alamofire with GCD
    func fetchData(completion: @escaping(Result<KPCollectionsSection, AFError>) -> Void) {
        AF.request(EnumLinks.getCollectionsUrl.rawValue, headers: headers)
            .validate()
            .responseDecodable(of: KPCollectionsSection.self, decoder: decoder) { dataResponse in
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
    
//    func fetchImage(from url: URL, completion: @escaping(Result<Data, AFError>) -> Void) {
//        AF.request(url)
//            .validate()
//            .responseData { dataResponse in
//                switch dataResponse.result {
//                case .success(let imageData):
//                    completion(.success(imageData))
//                case .failure(let error):
//                    print(error)
//                    completion(.failure(error))
//                }
//            }
//    }
    
//    func fetchImage(from url: String, completion: @escaping(Result<UIImage, AFError>) -> Void) {
//        AF.request(url)
//            .responseImage { response in
//                switch response.result {
//                case .success(let image):
//                    completion(.success(image))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//    
//    func fetchImage(from url: String) async throws -> UIImage {
//        let image: UIImage
//        
//        AF.request(url)
//            .responseImage { [weak self] response in
//                switch response.result {
//                case .success(let image):
//                    image = image
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
    
}
