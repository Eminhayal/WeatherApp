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
        let detailVC = DetailVC.instantiate()
        let detailVM = DetailVM()
        detailVC.weatherData = weatherData
        detailVC.viewModel = detailVM
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
