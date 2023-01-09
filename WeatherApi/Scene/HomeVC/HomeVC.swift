//
//  ViewController.swift
//  WeatherApi
//
//  Created by Emin Hayal on 2.01.2023.
//

import UIKit

class HomeVC: UIViewController  {

    var viewModel = HomeVM()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getServiceData()
    }
}

extension HomeVC: HomeFlowVMDelegateOutputs {
    func handleViewModelOutputs(_ viewModelOutputs: HomeFlowVMOutputs) {
        switch viewModelOutputs {
        case .Succes:
            print("Success")
        case .error(let string):
            print(string)
        }
    }
    
}
