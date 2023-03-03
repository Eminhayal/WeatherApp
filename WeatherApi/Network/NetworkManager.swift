//
//  NetworkManager.swift
//  WeatherApi
//
//  Created by Emin Hayal on 2.01.2023.
//

import UIKit

let network = NetworkManager()

final class NetworkManager {
    
    init() { }
    
    func request<T: Codable>(type: T.Type, url: String, method: HTTPMethods, completion: @escaping((Result<T, ErrorTypes>) -> (Void))) {
        let session = URLSession.shared
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            let dataTask = session.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let _ = error {
                        completion(.failure(.requestFailed))
                    } else if let data = data {
                        self.handleResponse(data: data) { response in
                             completion(response)
                        }
                    } else {
                        completion(.failure(.badURL))
                    }
                }
              
            }
            dataTask.resume()
        }
    }
    
    fileprivate func handleResponse<T: Codable>(data: Data, completion: @escaping((Result<T, ErrorTypes>) -> (Void))) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(.invalidData))
        }
    }
}
