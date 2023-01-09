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
    func getServiceData()
    var weatherData : Weather? {get set }
}

protocol HomeFlowVMDelegateOutputs: AnyObject{
    func handleViewModelOutputs(_ viewModelOutputs: HomeFlowVMOutputs )
    
}

enum HomeFlowVMOutputs {
    case Succes
    case error(String)
}


class HomeVM: HomeFlowVMDelegate{
    var weatherData: Weather?
    var delegate: HomeFlowVMDelegateOutputs?
    var network: Network = Api()
    let url = "https://api.tomorrow.io/v4/timelines?location=42.3478%2C%20-71.0466&fields=temperature&units=metric&timesteps=1h&timesteps=5m&startTime=now&endTime=nowPlus6h&apikey=EFxtVbCYRGe1idawi0upNXptVTZz4vlW"
    func getServiceData() {
        network.getWeatherData(url: url) { ( response, error )in
            if let response = response {
                self.weatherData = response
                print(response)
            }else {
                print(error)
            }
        }
    }
    
}
