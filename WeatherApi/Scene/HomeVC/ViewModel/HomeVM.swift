//
//  HomeVM.swift
//  WeatherApi
//
//  Created by Emin Hayal on 2.01.2023.
//

import Foundation

protocol HomeFlowVMProtocol {
    
    // MARK: Variable
    var weatherData: [Weather] { get set }
    var view: HomeVCProtocol? {get set}
    
    // MARK: Func
    func viewDidLoad()
    func viewWillAppear()
    
    func pulledRefreshController()
    func didSelectRowAt(at indexPath: IndexPath)
    func fetchData(complete: @escaping((String?) -> (Void)))
    func setupUI()
}

final class HomeVM {
    weak var view: HomeVCProtocol?
    var coordinator: HomeCoordinator?
    var weatherData: [Weather] = []
    private var pulledDownRefreshController: Bool = false
    var nameCities: [String] = ["Ankara", "İstanbul", "İzmir" ]
    var citiesLongitudeLatitude: [String] = ["38.4164303,26.5384468", "41.0049823,28.7320024", "39.9031237,32.6226822"]
    
    func fetchData(complete: @escaping((String?) -> (Void))) {
        view?.beginRefreshing()
        citiesLongitudeLatitude.forEach({ citiesLongitudeLatitude in
            let url = "https://api.tomorrow.io/v4/timelines?location=\(citiesLongitudeLatitude)&fields=temperature&units=metric&timesteps=1h&startTime=now&endTime=nowPlus6h&apikey=EFxtVbCYRGe1idawi0upNXptVTZz4vlW"
            
            WeatherNetworkManager.shared.getWeatherItems(url: url) { [weak self] response, errorMessage in
                if let response = response {
                    self?.weatherData.append(response)
                    self?.view?.endRefreshing()
                    self?.view?.reloadData()
                }
                complete(errorMessage)
            }
        })
        
    }
    
}

extension HomeVM: HomeFlowVMProtocol {
    
    func viewDidLoad() {
        view?.prepareTableView()
        fetchData { errorMessage in
            if let errorMessage = errorMessage {
                print("Error: \(errorMessage)")
                self.view?.setAlert(msg: errorMessage)
            }
            self.view?.reloadData()
        }
    }
    
    func viewWillAppear() {
        view?.prepareRefreshController(tintColor: "red")
    }
    
    func setupUI() {
        view?.setupUI()
    }
    
    func pulledRefreshController() {
        guard let isDragging = view?.isDragging, !isDragging else {
            weatherData = []
            fetchData { errorMessage in
                if let errorMessage = errorMessage {
                    print("Error: \(errorMessage)")
                    self.view?.setAlert(msg: errorMessage)
                }
                self.view?.reloadData()
                self.view?.endRefreshing()
            }
            pulledDownRefreshController = true
            return
        }
    }
    
    func didSelectRowAt(at indexPath: IndexPath) {
        coordinator?.showDetailVC(weatherData: weatherData[indexPath.row])
    }
    
}
