//
//  HomeCoordinator.swift
//  WeatherApi
//
//  Created by Emin Hayal on 4.03.2023.
//

import Foundation
import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = HomeVC.instantiate(name: .main)
        let viewModel = HomeVM()
        controller.viewModel = viewModel
        viewModel.coordinator = self
        navigationController.show(controller, sender: nil)
    }
    
    func showDetailVC(weatherData: Weather) {
        let controller = DetailVC.instantiate(name: .detail)
        let viewModel = DetailVM()
        controller.viewModel = viewModel
        controller.weatherData = weatherData
        navigationController.pushViewController(controller, animated: true)

    }
}
