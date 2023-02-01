//
//  AppRouter.swift
//  WeatherApi
//
//  Created by Emin Hayal on 2.01.2023.
//


import UIKit

final class AppRouter {
    
    static var shared = AppRouter()
    
    init() {}
    
    func showDetailPage(_ navigationController: UINavigationController?, weatherData: Weather) {
        let vc = DetailVC.instantiate()
        let vm = DetailVM()
        vc.weatherData = weatherData
        vc.viewModel = vm
        navigationController?.pushViewController(vc, animated: true)
    }
}
