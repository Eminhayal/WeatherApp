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
    
    func postData<T: Codable, K: Encodable>(url: String, params: K, completion: @escaping (T?) -> Void) {
        
    }
}
