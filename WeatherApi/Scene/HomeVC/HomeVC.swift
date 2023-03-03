//
//  ViewController.swift
//  WeatherApi
//
//  Created by Emin Hayal on 2.01.2023.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    var viewModel = HomeVM()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 4
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        viewModel.fetchData { errorMessage in
            if let errorMessage = errorMessage {
                print("error:\(errorMessage)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherCell.nibName, forCellReuseIdentifier: WeatherCell.identifier)
        viewModel.delegate = self
        layout()
        setNavigation()
        view.backgroundColor = .darkGray
    }
    
    private func setNavigation() {
        navigationItem.title = "Weather"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
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
        case .error(let string):
            DispatchQueue.main.async { [weak self] in
                self?.setAlert(msg: string)
            }
            
        case .setLoading(_):
            break
        case .showWeatherList(_):
            break
        }
    }
    
    func setAlert(msg: String) {
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
        
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherData.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as? WeatherCell
        let data = viewModel.weatherData[indexPath.row]
        cell?.weatherData = data.data?.timelines
        cell?.contentView.backgroundColor = .gray
        if let timeline = data.data?.timelines {
            cell?.configureData(data: timeline)
        }
        cell?.locationNameCityLabel.text = viewModel.nameCities[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.weatherData
        AppRouter.shared.showDetailPage(self.navigationController, weatherData: data[indexPath.row])
    }
}
