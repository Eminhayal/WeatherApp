//
//  ViewController.swift
//  WeatherApi
//
//  Created by Emin Hayal on 2.01.2023.
//

import UIKit
import SnapKit

class HomeVC: UIViewController  {

    var viewModel = HomeVM()
    var filteredData: [LocationCityElement] = []

    private lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.rowHeight = 100
            tableView.separatorStyle = .none
            tableView.backgroundColor = .blue
            tableView.layer.cornerRadius = 16
            return tableView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
    }
    
    private func SetupUI() {
        viewModel.getServiceData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherCell.nibName, forCellReuseIdentifier: WeatherCell.identifier)
        viewModel.delegate = self
        viewModel.getLocation()
        layout()
      
    }
    
    private func layout() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(10)
            
        }
    }
}

extension HomeVC: HomeFlowVMDelegateOutputs {
    func handleViewModelOutputs(_ viewModelOutputs: HomeFlowVMOutputs) {
        switch viewModelOutputs {
        case .Succes:
            tableView.reloadData()
        case .error(let string):
            print(string)
        }
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return viewModel.weatherData?.data?.timelines?.count ?? 0
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
        let data = viewModel.weatherData?.data?.timelines
        if let data = data {
            cell.timeStepLabel.text = data[indexPath.row].timestep
            cell.weatherData = data
        }
      
        cell.backgroundColor = .red
        cell.contentView.backgroundColor = .brown
        cell.timeStepLabel.text = viewModel.weatherData?.data?.timelines?[indexPath.row].timestep
        data?.forEach({ Timeline in
            Timeline.intervals?.forEach({ data in
                cell.setupData(data: data)

            })
        })
        cell.locationNameLabel.text = "Ankara"

        return cell
    }
    
    
}
