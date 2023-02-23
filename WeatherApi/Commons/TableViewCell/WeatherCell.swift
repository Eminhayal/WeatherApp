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
        temperatureLabel.font = UIFont(name: temperatureLabel.font.fontName, size: 30)
       return temperatureLabel
   }()
    lazy var clockLabel: UILabel = {
       let clockLabel = UILabel()
       return clockLabel
   }()
    lazy var locationNameCityLabel: UILabel = {
       let locationNameCityLabel = UILabel()
        locationNameCityLabel.font = UIFont(name: locationNameCityLabel.font.fontName, size: 24)
       return locationNameCityLabel
   }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
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
    var weatherInterval: [Interval]?
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
    
    func configureData(data: [Timeline]) {
        data.forEach { data in
            self.weatherInterval = data.intervals
            self.timeStepLabel.text = data.timestep
        }
        
        data.forEach { timeline in
            timeline.intervals?.forEach({ interval in
                if let tempData = interval.values?.temperature {
                    let temp = Int(tempData)
                    self.temperatureLabel.text = "\(temp)  °C"
                }
            })
        }
        
        let hour = self.calendar.component(.hour, from: self.date)
        let minutes = self.calendar.component(.minute, from: self.date)
        clockLabel.text = "\(hour) : \(minutes)"
        
    }
    
    private func layout() {
        
        // MARK: collectionview
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.leading.trailing.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
        
        // MARK: Temperature
        self.contentView.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(50)
        }
        
        // MARK: TimeStep
       self.locationNameCityLabel.addSubview(timeStepLabel)
        timeStepLabel.snp.makeConstraints { make in
            make.top.equalTo(locationNameCityLabel.snp.top).offset(5)
            make.left.equalTo(locationNameCityLabel.snp.right).offset(20)
        }
        
        // MARK: LocationName
       self.contentView.addSubview(locationNameCityLabel)
        locationNameCityLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(50)
        }
        
        // MARK: Clock
        self.locationNameCityLabel.addSubview(clockLabel)
         clockLabel.snp.makeConstraints { make in
             make.top.equalTo(locationNameCityLabel.snp.bottom).offset(20)
         }
    }
    
}

extension WeatherCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        weatherData?.forEach({ data in
            data.intervals?.forEach({ dataInterval in
                count += 1
            })
        })
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell
        cell?.backgroundColor = .clear
        
        if let data = weatherInterval {
            if let tempData = data[indexPath.row].values?.temperature {
                let tempValue = Int(tempData)
                cell?.tempLabel.text = "\(tempData.rounded()) °C  "

            }
            cell?.timeLabel.text = weatherInterval?[indexPath.row].startTime
            if let interval = weatherInterval {
                cell?.configureData(tempData: interval[indexPath.row])
            }
        }
        return cell ?? UICollectionViewCell()
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
