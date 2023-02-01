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
        SetupUI()
    }
    
    private func SetupUI() {
        viewModel.getServiceData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherCell.nibName, forCellReuseIdentifier: WeatherCell.identifier)
        viewModel.delegate = self
        view.backgroundColor = .darkGray
        navigationItem.title = "Weather"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
            DispatchQueue.main.async { [weak self] in
                self?.setAlert(msg: string)
            }
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
        let data = viewModel.weatherData[indexPath.row]
        cell.weatherData = data.data?.timelines
        cell.contentView.backgroundColor = .gray
        if let timeline = data.data?.timelines {
            cell.configureData(data: timeline)
        }
        cell.locationNameLabel.text = viewModel.locationName[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.weatherData
        AppRouter.shared.showDetailPage(self.navigationController, weatherData: data[indexPath.row])
    }
}


extension HomeVC: StoryboardInstantiate {
    static var storyboardType: StoryboardType { return .home }
}
