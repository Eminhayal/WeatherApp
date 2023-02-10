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
    
    func getData<T: Codable>(url: String, completion: @escaping (T?, String?) -> Void) {
        let preparedURL = URL(string: url)
        //start
        let task = URLSession.shared.dataTask(with: preparedURL!) { (data, res, error) in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let responseObject = try JSONDecoder().decode(T.self, from: data)
                        completion(responseObject, nil)
                    }catch{
                        print("Empty Data ", error, error.localizedDescription)
                    }
                }
            }
        }
        task.resume()
    }
}

public extension URLComponents {
    
    init(scheme: String = "https",
         host: String = "api.myapp.com",
         path: String,
         queryItems: [URLQueryItem]? = nil) {
        
        var components = URLComponents()
        components.scheme = scheme
        components.path = path
        components.host = host
        components.queryItems = queryItems
        self = components
    }
}

extension URLComponents {
    
    static var users: Self {
        Self(path: "/users")
    }
    
    static func userDetail(id: String) -> Self {
        let queryItems: [URLQueryItem] = [.init(name: "id", value: id)]
        return Self(path: "/user", queryItems: queryItems)
    }
}
