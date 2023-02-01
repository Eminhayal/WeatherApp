//
//  DetailVC.swift
//  WeatherApi
//
//  Created by Emin Hayal on 29.01.2023.
//

import UIKit
import SnapKit

class DetailVC: UIViewController {
    
    var viewModel: DetailVM?
    
    lazy var weatherLabel: UILabel = {
        var weatherLabel = UILabel()
        return weatherLabel
    }()
    
    lazy var testMessageLabel: UILabel = {
        var testMessageLabel = UILabel()
        testMessageLabel.text = "Test Ekranı"
        return testMessageLabel
    }()
    
    var weatherData: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        layout()
    }
    
    func configureData() {
        
        var data = weatherData?.data?.timelines?.first
        if let dataWeather =  data?.intervals?.first?.values?.temperature {
            var dataInt = Int( dataWeather)
            weatherLabel.text = "\(dataInt)"
        }

    }
    
    func layout() {
        view.addSubview(weatherLabel)
        weatherLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.addSubview(testMessageLabel)
        testMessageLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-200)
            make.leading.equalToSuperview().offset(200)
        }
    }
    
}

extension DetailVC: StoryboardInstantiate {
    static var storyboardType: StoryboardType { return .detail }
}
