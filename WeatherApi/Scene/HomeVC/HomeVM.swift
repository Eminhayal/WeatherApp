//
//  HomeVM.swift
//  WeatherApi
//
//  Created by Emin Hayal on 2.01.2023.
//

import Foundation

protocol HomeFlowVMProtocol: AnyObject {
    
}

protocol HomeFlowVMDelegate: HomeFlowVMProtocol {
    var delegate: HomeFlowVMDelegateOutputs? { get set }
    func fetchData()
    var weatherData : [Weather] {get set }
    
}

protocol HomeFlowVMDelegateOutputs: AnyObject{
    func handleViewModelOutputs(_ viewModelOutputs: HomeFlowVMOutputs )
    
}

enum HomeFlowVMOutputs {
    case setLoading(Bool)
    case showWeatherList([Weather])
    case error(String)
}

class HomeVM: HomeFlowVMDelegate {

    var weatherData: [Weather] = []
    var delegate: HomeFlowVMDelegateOutputs?
    var network: Network = Api()
    var nameCities: [String] = ["Ankara", "İstanbul", "İzmir" ]
    var citiesLongitudeLatitude: [String] = ["38.4164303,26.5384468", "41.0049823,28.7320024", "39.9031237,32.6226822"]
    
    func fetchData() {
        for citiesLongitudeLatitude in citiesLongitudeLatitude {
            let url = "https://api.tomorrow.io/v4/timelines?location=\(citiesLongitudeLatitude)&fields=temperature&units=metric&timesteps=1h&startTime=now&endTime=nowPlus6h&apikey=EFxtVbCYRGe1idawi0upNXptVTZz4vlW"
            network.getWeatherData(url: url) { ( response, error )in
                if let response = response {
                    self.weatherData.append(response)
                    self.delegate?.handleViewModelOutputs(.succes)
                }else {
                    self.delegate?.handleViewModelOutputs(.error("Yeniden deneyiniz"))
                }
            }
        }
    }
    
}
