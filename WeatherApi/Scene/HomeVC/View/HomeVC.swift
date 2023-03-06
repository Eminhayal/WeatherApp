//
//  ViewController.swift
//  WeatherApi
//
//  Created by Emin Hayal on 2.01.2023.
//

import UIKit
import SnapKit

protocol HomeVCProtocol: AnyObject {
    var isDragging: Bool { get }
    
    func prepareTableView()
    func prepareRefreshController(tintColor: String)
    func setupUI()
    func beginRefreshing()
    func endRefreshing()
    func reloadData()
    func setAlert(msg: String)
    func setLayout()
    func setNavigation()
    func setColor()
}

class HomeVC: UIViewController, StoryboardSettings {
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
        viewModel.view = self
        viewModel.viewDidLoad()
        setupUI()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    @objc func pulledRefreshController(_ sender: AnyObject) {
        viewModel.pulledRefreshController()
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
        viewModel.didSelectRowAt(at: indexPath)
    }
}

extension HomeVC: HomeVCProtocol {
    
    var isDragging: Bool { tableView.isDragging }
    
    func setupUI() {
        viewModel.view?.setLayout()
        viewModel.view?.setNavigation()
        viewModel.view?.setColor()
    }

    func setLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    func setColor() {
        view.backgroundColor = .darkGray
    }
    
    func setNavigation() {
        navigationItem.title = "Weather"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func beginRefreshing() {
        tableView.refreshControl?.beginRefreshing()
        
    }
    
    func endRefreshing() {
        tableView.refreshControl?.endRefreshing()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
       
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherCell.nibName, forCellReuseIdentifier: WeatherCell.identifier)
    }
    
    func prepareRefreshController(tintColor: String) {
        let refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(pulledRefreshController), for: .valueChanged)
        refreshController.tintColor = .init(named: tintColor)
        tableView.refreshControl = refreshController
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
