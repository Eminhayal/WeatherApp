//
//  WeatherCell.swift
//  WeatherApi
//
//  Created by Emin Hayal on 15.01.2023.
//

import UIKit
import SnapKit

class WeatherCell: UITableViewCell {

     lazy var timeStepLabel: UILabel = {
        let timeStepLabel = UILabel()
        return timeStepLabel
    }()
    
    lazy var temperatureLabel: UILabel = {
       let temperatureLabel = UILabel()
        temperatureLabel.font = UIFont(name: locationNameLabel.font.fontName, size: 30)
       return temperatureLabel
   }()
    lazy var clockLabel: UILabel = {
       let clockLabel = UILabel()
       return clockLabel
   }()
    lazy var locationNameLabel: UILabel = {
       let locationNameLabel = UILabel()
        locationNameLabel.font = UIFont(name: locationNameLabel.font.fontName, size: 24)
       return locationNameLabel
   }()
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
        }()
    

    let myLabel: UILabel = {
        let myWeatherLabel = UILabel()
        myWeatherLabel.textColor = .white
        myWeatherLabel.textAlignment = .center
        myWeatherLabel.font = .systemFont(ofSize: 30, weight: .semibold) // set your font size here
        myWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return myWeatherLabel
    }()
    
    var weatherData : [Timeline]?
    let date = Date()
    let calendar = Calendar.current

    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeatherCollectionViewCell.nibName, forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        layout()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func layout() {
        //MARK: collectionview
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        //MARK: Temperature
        self.contentView.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(50)
        }
        
        //MARK: TimeStep
       self.locationNameLabel.addSubview(timeStepLabel)
        timeStepLabel.snp.makeConstraints { make in
            make.top.equalTo(locationNameLabel.snp.top).offset(5)
            make.left.equalTo(locationNameLabel.snp.right).offset(20)
        }
        
        //MARK: LocationName
       self.contentView.addSubview(locationNameLabel)
        locationNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(50)
        }
        
        //MARK: Clock
        self.locationNameLabel.addSubview(clockLabel)
         clockLabel.snp.makeConstraints { make in
             make.top.equalTo(locationNameLabel.snp.bottom).offset(20)
         }
    }
    
    func setupData (data : Interval ) {
        let hour = self.calendar.component(.hour, from: self.date)
        let minutes = self.calendar.component(.minute, from: self.date)
        if let data = data.values?.temperature {
            let temperature = Int(data)
            self.temperatureLabel.text = " \(String(temperature)) °C "
        }
        clockLabel.text = "\(hour) : \(minutes)"
    }
}

extension WeatherCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
        cell.backgroundColor = .clear
        if let data = weatherData {
            cell.tempData = data[indexPath.row].intervals ?? []
        }
        return cell
    }
    
    
}

extension WeatherCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nibName: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
